// Persona A. Arma una textura equirectangular del planeta completo uniendo los tiles WMTS de NASA Trek.
// Trek sirve los mosaicos en EPSG:4326: en el nivel z hay 2^(z+1) columnas por 2^z filas de 256 px,
// así que al pegarlos en orden sale justo la imagen que el globo 3D envuelve sobre la esfera.
// Trek responde con Access-Control-Allow-Origin: *, por eso el canvas no queda "contaminado".

const TILE = 256
const cache = new Map<string, Promise<string>>()

function loadTile(src: string): Promise<HTMLImageElement | null> {
  return new Promise((resolve) => {
    const img = new Image()
    img.crossOrigin = 'anonymous'
    img.onload = () => resolve(img)
    img.onerror = () => resolve(null) // un tile perdido deja un hueco oscuro, no rompe el globo
    img.src = src
  })
}

/** Devuelve un data URL JPEG con el planeta entero. `level` 2 = 2048×1024 px (32 tiles). */
export function planetTexture(urlTemplate: string, level = 2): Promise<string> {
  const key = `${urlTemplate}@${level}`
  const hit = cache.get(key)
  if (hit) return hit

  const job = (async () => {
    const cols = 2 ** (level + 1)
    const rows = 2 ** level
    const canvas = document.createElement('canvas')
    canvas.width = cols * TILE
    canvas.height = rows * TILE
    const ctx = canvas.getContext('2d')
    if (!ctx) throw new Error('Canvas 2D no disponible')
    ctx.fillStyle = '#1c1c1c'
    ctx.fillRect(0, 0, canvas.width, canvas.height)

    const jobs: Promise<void>[] = []
    for (let y = 0; y < rows; y++) {
      for (let x = 0; x < cols; x++) {
        const src = urlTemplate.replace('{z}', String(level)).replace('{y}', String(y)).replace('{x}', String(x))
        jobs.push(loadTile(src).then((img) => { if (img) ctx.drawImage(img, x * TILE, y * TILE) }))
      }
    }
    await Promise.all(jobs)
    return canvas.toDataURL('image/jpeg', 0.9)
  })()

  job.catch(() => cache.delete(key)) // si falla, se vuelve a intentar la próxima vez
  cache.set(key, job)
  return job
}
