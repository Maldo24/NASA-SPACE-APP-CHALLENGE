import { useEffect, useRef, type MutableRefObject } from 'react'
import type { GlobeMethods } from 'react-globe.gl'
import type { BodyId } from '../../types/domain'

// Ancla los astros en coordenadas del mundo. Solo se proyectan a la pantalla:
// al orbitar la cámara cambian de posición y pueden salir del encuadre.
export function useSpacePerspective(
  globeRef: MutableRefObject<GlobeMethods | undefined>, ready: boolean, body: BodyId,
) {
  const skyRef = useRef<HTMLDivElement>(null)
  const sunRef = useRef<HTMLDivElement>(null)
  const earthRef = useRef<HTMLDivElement>(null)
  const earthLight = useRef<[number, number, number]>([-.8, .45, .7])

  useEffect(() => {
    const globe = globeRef.current
    const sky = skyRef.current
    if (!ready || !globe || !sky) return
    // pointOfView cambia la posición antes del siguiente render. Sin actualizar
    // los controles aquí, se anclarían los astros con la orientación anterior.
    globe.controls().update()
    const camera = globe.camera()
    camera.updateMatrixWorld()
    const e = camera.matrixWorld.elements
    const origin = camera.position
    const depth = 3500 // Escala visual, no distancia astronómica.
    const anchor = (element: HTMLDivElement | null, x: number, y: number) => {
      const right = x * depth / camera.projectionMatrix.elements[0]
      const up = y * depth / camera.projectionMatrix.elements[5]
      const world = {
        x: origin.x + e[0] * right + e[4] * up - e[8] * depth,
        y: origin.y + e[1] * right + e[5] * up - e[9] * depth,
        z: origin.z + e[2] * right + e[6] * up - e[10] * depth,
      }
      return { element, world, geo: globe.toGeoCoords(world) }
    }
    const anchors = [anchor(sunRef.current, -.72, .7), anchor(earthRef.current, .63, .6)]
    let frame = 0
    const project = () => {
      frame = 0
      camera.updateMatrixWorld()
      const matrix = camera.matrixWorld.elements
      for (const { element, world, geo } of anchors) {
        if (!element) continue
        const forwardDepth = -((world.x - camera.position.x) * matrix[8]
          + (world.y - camera.position.y) * matrix[9] + (world.z - camera.position.z) * matrix[10])
        element.style.visibility = forwardDepth > 0 ? 'visible' : 'hidden'
        if (forwardDepth <= 0) continue
        const point = globe.getScreenCoords(geo.lat, geo.lng, geo.altitude)
        const scale = Math.min(3, depth / forwardDepth)
        element.style.transform = `translate3d(${point.x}px, ${point.y}px, 0) translate(-50%, -50%) scale(${scale})`
      }
      const pov = globe.pointOfView()
      sky.style.setProperty('--sky-x', `${pov.lng * 5}px`)
      sky.style.setProperty('--sky-y', `${-pov.lat * 5}px`)
      sky.style.setProperty('--sky-far-x', `${pov.lng * 2.5}px`)
      sky.style.setProperty('--sky-far-y', `${-pov.lat * 2.5}px`)
      const light = {
        x: anchors[0].world.x - anchors[1].world.x,
        y: anchors[0].world.y - anchors[1].world.y,
        z: anchors[0].world.z - anchors[1].world.z,
      }
      earthLight.current = [
        light.x * matrix[0] + light.y * matrix[1] + light.z * matrix[2],
        light.x * matrix[4] + light.y * matrix[5] + light.z * matrix[6],
        light.x * matrix[8] + light.y * matrix[9] + light.z * matrix[10],
      ]
      earthRef.current?.querySelector('canvas')?.dispatchEvent(new Event('space-view-change'))
    }
    const schedule = () => { if (!frame) frame = requestAnimationFrame(project) }
    const controls = globe.controls()
    controls.addEventListener('change', schedule)
    const resize = new ResizeObserver(schedule)
    resize.observe(sky)
    project()
    return () => {
      cancelAnimationFrame(frame)
      controls.removeEventListener('change', schedule)
      resize.disconnect()
    }
  }, [globeRef, ready, body])

  return { skyRef, sunRef, earthRef, earthLight }
}
