import { useEffect, useRef, useState, type MutableRefObject } from 'react'

// Esfera decorativa pequeña: la textura gira sobre su eje, no como una foto plana.
// Comparte el criterio visual del Sol del fondo; no es una efeméride.
export default function BackgroundEarth({ light }: { light: MutableRefObject<[number, number, number]> }) {
  const canvasRef = useRef<HTMLCanvasElement>(null)
  const [rendered, setRendered] = useState(false)

  useEffect(() => {
    const canvas = canvasRef.current
    const gl = canvas?.getContext('webgl', { alpha: true, antialias: true })
    if (!gl) return // La fotografía local sigue visible si no hay WebGL.
    let alive = true
    let frame = 0
    let elapsed = 0
    let previous = 0
    const motion = window.matchMedia('(prefers-reduced-motion: reduce)')
    const vertex = gl.createShader(gl.VERTEX_SHADER)!
    gl.shaderSource(vertex, 'attribute vec2 position; varying vec2 uv; void main(){ uv=position*.5+.5; gl_Position=vec4(position,0.,1.); }')
    gl.compileShader(vertex)
    const fragment = gl.createShader(gl.FRAGMENT_SHADER)!
    gl.shaderSource(fragment, `
      precision mediump float;
      varying vec2 uv;
      uniform sampler2D surface;
      uniform float rotation;
      uniform vec3 lightDirection;
      void main() {
        vec2 p = (uv - .5) * 2.04;
        float r = dot(p, p);
        if (r > 1.) discard;
        vec3 normal = vec3(p, sqrt(1. - r));
        // Inclinación del eje y proyección esférica de la textura equirectangular.
        vec2 tilted = mat2(.917, -.399, .399, .917) * normal.xy;
        vec2 map = vec2(atan(tilted.x, normal.z) / 6.283185 + .5 + rotation,
                        asin(clamp(tilted.y, -1., 1.)) / 3.141593 + .5);
        vec3 color = texture2D(surface, map).rgb;
        float daylight = smoothstep(-.15, .9, dot(normal, normalize(lightDirection)));
        vec3 rim = vec3(.12, .4, .7) * pow(1. - normal.z, 3.) * daylight;
        gl_FragColor = vec4(color * (.045 + .955 * daylight) + rim, 1.);
      }
    `)
    gl.compileShader(fragment)
    const program = gl.createProgram()!
    gl.attachShader(program, vertex)
    gl.attachShader(program, fragment)
    gl.linkProgram(program)
    if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
      gl.deleteProgram(program); gl.deleteShader(vertex); gl.deleteShader(fragment)
      return
    }
    gl.useProgram(program)
    const buffer = gl.createBuffer()
    gl.bindBuffer(gl.ARRAY_BUFFER, buffer)
    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array([-1, -1, 1, -1, -1, 1, 1, 1]), gl.STATIC_DRAW)
    const position = gl.getAttribLocation(program, 'position')
    gl.enableVertexAttribArray(position)
    gl.vertexAttribPointer(position, 2, gl.FLOAT, false, 0, 0)
    const texture = gl.createTexture()
    gl.bindTexture(gl.TEXTURE_2D, texture)
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR)
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT)
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE)
    const rotation = gl.getUniformLocation(program, 'rotation')
    const lightDirection = gl.getUniformLocation(program, 'lightDirection')
    const draw = (time: number) => {
      if (previous && !motion.matches) elapsed += Math.min(time - previous, 100)
      previous = time
      gl.uniform1f(rotation, elapsed / 60000)
      gl.uniform3f(lightDirection, ...light.current)
      gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4)
      if (!motion.matches && !document.hidden) frame = requestAnimationFrame(draw)
    }
    let loaded = false
    const updateLight = () => { if (loaded && motion.matches) draw(performance.now()) }
    canvas?.addEventListener('space-view-change', updateLight)
    const resume = () => {
      cancelAnimationFrame(frame)
      previous = 0
      if (loaded && !document.hidden) draw(performance.now())
    }
    const image = new Image()
    image.onload = () => {
      if (!alive) return
      gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true)
      gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGB, gl.RGB, gl.UNSIGNED_BYTE, image)
      loaded = true
      setRendered(true)
      resume()
    }
    image.src = '/img/space/earth-blue-marble.jpg'
    motion.addEventListener('change', resume)
    document.addEventListener('visibilitychange', resume)
    return () => {
      alive = false
      cancelAnimationFrame(frame)
      motion.removeEventListener('change', resume)
      document.removeEventListener('visibilitychange', resume)
      image.onload = null
      canvas?.removeEventListener('space-view-change', updateLight)
      gl.deleteTexture(texture); gl.deleteBuffer(buffer)
      gl.deleteProgram(program); gl.deleteShader(vertex); gl.deleteShader(fragment)
    }
  }, [light])

  return <div className={`space-earth${rendered ? ' is-rendered' : ''}`}>
    <canvas ref={canvasRef} width={256} height={256} />
  </div>
}
