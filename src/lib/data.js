// Capa de acceso a datos: todo el resto de la app solo usa estas funciones.
// Si algún día hay backend, solo cambia este archivo.
import moonZones from '../data/zones-moon.json'
import marsZones from '../data/zones-mars.json'
import analogs from '../data/analogs.json'

const ZONES = { moon: moonZones, mars: marsZones }
const ANALOGS_BY_ID = Object.fromEntries(analogs.map((a) => [a.id, a]))

export function getZones(body) {
  return ZONES[body]
}

// Devuelve { geomorphological: [...], mineralogical: [...], ... } para una zona
export function getAnalogsForZone(zone) {
  const grouped = {}
  for (const id of zone.properties.analogIds ?? []) {
    const a = ANALOGS_BY_ID[id]
    if (!a) { console.warn(`Análogo no encontrado: ${id}`); continue }
    ;(grouped[a.category] ??= []).push(a)
  }
  return grouped
}
