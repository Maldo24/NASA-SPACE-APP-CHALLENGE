// Persona A. ÚNICO punto de acceso a datos. Los componentes solo usan estas funciones.
//
// Contrato (no cambiar nombres ni forma sin avisar al equipo):
//   getBodies()                -> Body[]
//   getZones(bodyId)           -> Zone[]
//   getZone(zoneId)            -> Zone | null
//   getAnalogsForZone(zoneId)  -> AnalogsByCategory (siempre las 4 categorías; [] si no hay)
//
// Por ahora los datos salen de los JSON de src/data/ (semilla). La relación zona–análogo
// se arma como una tabla zone_analogs, igual que en Supabase, para que pasar a Supabase
// (paso 4) solo cambie la fuente y no esta API.
import moonZones from '../data/zones-moon.json'
import marsZones from '../data/zones-mars.json'
import analogsSeed from '../data/analogs.json'
import { LAYERS } from '../config/layers.ts'
import {
  CATEGORY_IDS,
  type Analog,
  type AnalogsByCategory,
  type Body,
  type BodyId,
  type Polygon,
  type Zone,
  type ZoneAnalogRow,
} from '../types/domain.ts'

// ---------------------------------------------------------------------
// Fuente de datos: semilla JSON
// ---------------------------------------------------------------------
type SeedZoneFeature = {
  properties: {
    id: string
    name: string
    zoneType: string
    description: string
    analogIds?: string[]
  }
  geometry: { type: string; coordinates: number[][][] }
}

type SeedAnalog = Omit<Analog, 'category' | 'image' | 'source'> & {
  category: string
  image?: string | null
  source?: string | null
}

const BODY_IDS: readonly BodyId[] = ['moon', 'mars']
const SEED_ZONES: Record<BodyId, { features: SeedZoneFeature[] }> = { moon: moonZones, mars: marsZones }

// Cadena vacía o ausente = pendiente (null), como en Supabase.
const orNull = (v: string | null | undefined) => (v ? v : null)

const isCategory = (c: string): c is Analog['category'] =>
  (CATEGORY_IDS as readonly string[]).includes(c)

function loadSeed() {
  const bodies: Body[] = BODY_IDS.map((id) => ({
    id,
    name: LAYERS[id].name,
    layerUrl: LAYERS[id].url,
    attribution: LAYERS[id].attribution,
    maxZoom: LAYERS[id].maxZoom,
  }))

  const zones: Zone[] = []
  const zoneAnalogs: ZoneAnalogRow[] = []
  for (const bodyId of BODY_IDS) {
    for (const f of SEED_ZONES[bodyId].features) {
      const p = f.properties
      zones.push({
        id: p.id,
        bodyId,
        name: p.name,
        zoneType: p.zoneType,
        description: p.description,
        geometry: f.geometry as Polygon,
      })
      for (const analogId of p.analogIds ?? []) zoneAnalogs.push({ zone_id: p.id, analog_id: analogId })
    }
  }

  const analogs: Analog[] = []
  for (const a of analogsSeed as SeedAnalog[]) {
    if (!isCategory(a.category)) {
      console.warn(`Análogo ${a.id} con categoría desconocida: ${a.category}`)
      continue
    }
    analogs.push({ ...a, category: a.category, image: orNull(a.image), source: orNull(a.source) })
  }

  return { bodies, zones, analogs, zoneAnalogs }
}

const seed = loadSeed()
const ANALOGS_BY_ID = new Map(seed.analogs.map((a) => [a.id, a]))

// ---------------------------------------------------------------------
// API pública
// ---------------------------------------------------------------------
export async function getBodies(): Promise<Body[]> {
  return seed.bodies
}

export async function getZones(bodyId: BodyId): Promise<Zone[]> {
  return seed.zones.filter((z) => z.bodyId === bodyId)
}

export async function getZone(zoneId: string): Promise<Zone | null> {
  return seed.zones.find((z) => z.id === zoneId) ?? null
}

export function emptyAnalogsByCategory(): AnalogsByCategory {
  return Object.fromEntries(CATEGORY_IDS.map((c) => [c, []])) as unknown as AnalogsByCategory
}

export async function getAnalogsForZone(zoneId: string): Promise<AnalogsByCategory> {
  const grouped = emptyAnalogsByCategory()
  for (const row of seed.zoneAnalogs) {
    if (row.zone_id !== zoneId) continue
    const analog = ANALOGS_BY_ID.get(row.analog_id)
    if (!analog) { console.warn(`Análogo no encontrado: ${row.analog_id}`); continue }
    grouped[analog.category].push(analog)
  }
  return grouped
}
