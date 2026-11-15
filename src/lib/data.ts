// Persona A. ÚNICO punto de acceso a datos. Los componentes solo usan estas funciones.
//
// Contrato (no cambiar nombres ni forma sin avisar al equipo):
//   getBodies()                -> Body[]
//   getZones(bodyId)           -> Zone[]
//   getZone(zoneId)            -> Zone | null
//   getAnalogsForZone(zoneId)  -> AnalogsByCategory (siempre las 4 categorías; [] si no hay)
//
// Fuentes de datos (misma API, se elige una al cargar):
//   1. Supabase, si existen VITE_SUPABASE_URL y VITE_SUPABASE_ANON_KEY (ver lib/supabase.ts).
//   2. Si no, la semilla JSON de src/data/. La relación zona–análogo se arma como una tabla
//      zone_analogs, igual que en Supabase.
import moonZones from '../data/zones-moon.json'
import marsZones from '../data/zones-mars.json'
import analogsSeed from '../data/analogs.json'
import { LAYERS } from '../config/layers.ts'
import { supabase } from './supabase.ts'
import {
  CATEGORY_IDS,
  TRAINING_AUDIENCES,
  type Analog,
  type AnalogAspect,
  type AnalogRow,
  type AnalogTraining,
  type TrainingAudience,
  type AnalogsByCategory,
  type Body,
  type BodyId,
  type BodyRow,
  type Polygon,
  type Zone,
  type ZoneAnalogRow,
  type ZoneRow,
} from '../types/domain.ts'

// Lo que cada fuente debe saber hacer. La agrupación por categoría es común.
interface DataSource {
  name: string
  bodies(): Promise<Body[]>
  zones(bodyId: BodyId): Promise<Zone[]>
  zone(zoneId: string): Promise<Zone | null>
  analogsForZone(zoneId: string): Promise<Analog[]>
}

// ---------------------------------------------------------------------
// Fuente de datos: semilla JSON
// ---------------------------------------------------------------------
type SeedZoneFeature = {
  properties: {
    id: string
    name: string
    zoneType: string
    description: string
    geology?: string | null
    environment?: string | null
    exploration?: string | null
    importance?: string | null
    sources?: string[]
    analogIds?: string[]
  }
  geometry: { type: string; coordinates: number[][][] }
}

// Aspectos y entrenamientos tal como los escribe exportar-json.sh (sin validar todavía).
type RawAspect = { category: string; covers: string; breaks: string; source?: string | null }
type RawTraining = {
  audience: string; activity: string; measures: string
  restrictions?: string | null; source?: string | null; position?: number
}

type SeedAnalog = Pick<Analog, 'id' | 'name' | 'lat' | 'lon' | 'why'> & {
  category: string
  image?: string | null
  source?: string | null
  secondary_categories?: string[]
  breaking_point?: string | null
  aspects?: RawAspect[]
  trainings?: RawTraining[]
}

const BODY_IDS: readonly BodyId[] = ['moon', 'mars']
const SEED_ZONES: Record<BodyId, { features: SeedZoneFeature[] }> = { moon: moonZones, mars: marsZones }

// Cadena vacía o ausente = pendiente (null), como en Supabase.
const orNull = (v: string | null | undefined) => (v ? v : null)

const isCategory = (c: string): c is Analog['category'] =>
  (CATEGORY_IDS as readonly string[]).includes(c)

const isAudience = (a: string): a is TrainingAudience =>
  (TRAINING_AUDIENCES as readonly string[]).includes(a)

// Comunes a las dos fuentes: descartan valores desconocidos y fijan el orden.
function toAspects(raw: RawAspect[] | undefined): AnalogAspect[] {
  return (raw ?? [])
    .filter((s) => isCategory(s.category))
    .map((s) => ({ category: s.category as AnalogAspect['category'], covers: s.covers, breaks: s.breaks, source: orNull(s.source) }))
    .sort((x, y) => CATEGORY_IDS.indexOf(x.category) - CATEGORY_IDS.indexOf(y.category))
}

function toTrainings(raw: RawTraining[] | undefined): AnalogTraining[] {
  return [...(raw ?? [])]
    .sort((x, y) => (x.position ?? 0) - (y.position ?? 0))
    .filter((t) => isAudience(t.audience))
    .map((t) => ({
      audience: t.audience as TrainingAudience, activity: t.activity, measures: t.measures,
      restrictions: orNull(t.restrictions), source: orNull(t.source),
    }))
}

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
        geology: orNull(p.geology),
        environment: orNull(p.environment),
        exploration: orNull(p.exploration),
        importance: orNull(p.importance),
        sources: p.sources ?? [],
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
    analogs.push({
      id: a.id, name: a.name, lat: a.lat, lon: a.lon, why: a.why,
      category: a.category,
      image: orNull(a.image),
      source: orNull(a.source),
      secondaryCategories: (a.secondary_categories ?? []).filter(isCategory),
      breakingPoint: orNull(a.breaking_point),
      aspects: toAspects(a.aspects),
      trainings: toTrainings(a.trainings),
    })
  }

  return { bodies, zones, analogs, zoneAnalogs }
}

function createSeedSource(): DataSource {
  const seed = loadSeed()
  const analogsById = new Map(seed.analogs.map((a) => [a.id, a]))

  return {
    name: 'semilla JSON',
    bodies: async () => seed.bodies,
    zones: async (bodyId) => seed.zones.filter((z) => z.bodyId === bodyId),
    zone: async (zoneId) => seed.zones.find((z) => z.id === zoneId) ?? null,
    analogsForZone: async (zoneId) => {
      const result: Analog[] = []
      for (const row of seed.zoneAnalogs) {
        if (row.zone_id !== zoneId) continue
        const analog = analogsById.get(row.analog_id)
        if (analog) result.push(analog)
        else console.warn(`Análogo no encontrado: ${row.analog_id}`)
      }
      return result
    },
  }
}

// ---------------------------------------------------------------------
// Fuente de datos: Supabase (filas snake_case -> dominio camelCase)
// ---------------------------------------------------------------------
const toBody = (r: BodyRow): Body => ({
  id: r.id,
  name: r.name,
  layerUrl: r.layer_url,
  attribution: r.attribution,
  maxZoom: r.max_zoom,
})

const toZone = (r: ZoneRow): Zone => ({
  id: r.id,
  bodyId: r.body_id,
  name: r.name,
  zoneType: r.zone_type,
  description: r.description,
  geometry: r.geometry,
  geology: orNull(r.geology),
  environment: orNull(r.environment),
  exploration: orNull(r.exploration),
  importance: orNull(r.importance),
  sources: r.sources ?? [],
})

const toAnalog = (r: AnalogRow): Analog => ({
  id: r.id, name: r.name, category: r.category, lat: r.lat, lon: r.lon, why: r.why,
  image: orNull(r.image),
  source: orNull(r.source),
  secondaryCategories: r.secondary_categories ?? [],
  breakingPoint: orNull(r.breaking_point),
  aspects: toAspects(r.analog_aspects),
  trainings: toTrainings(r.analog_trainings),
})

const BODY_COLUMNS = 'id, name, layer_url, attribution, max_zoom'
const ZONE_COLUMNS = 'id, body_id, name, zone_type, description, geometry, geology, environment, exploration, importance, sources'
// Los límites y entrenamientos se piden embebidos (FK analog_id -> analogs.id) en la misma consulta.
const ANALOG_COLUMNS = 'id, name, category, lat, lon, why, image, source, secondary_categories, breaking_point, '
  + 'analog_aspects (category, covers, breaks, source), '
  + 'analog_trainings (position, audience, activity, measures, restrictions, source)'

// Sin tipos generados de Supabase, las respuestas llegan sin tipar; se validan con los tipos de domain.ts.
function check<T>(what: string, res: { data: unknown; error: { message: string } | null }): T {
  if (res.error) throw new Error(`Supabase (${what}): ${res.error.message}`)
  return res.data as T
}

function createSupabaseSource(db: NonNullable<typeof supabase>): DataSource {
  return {
    name: 'Supabase',
    bodies: async () =>
      check<BodyRow[]>('bodies', await db.from('bodies').select(BODY_COLUMNS).order('id')).map(toBody),

    zones: async (bodyId) =>
      check<ZoneRow[]>('zones', await db.from('zones').select(ZONE_COLUMNS).eq('body_id', bodyId).order('id'))
        .map(toZone),

    zone: async (zoneId) => {
      const row = check<ZoneRow | null>('zone', await db.from('zones').select(ZONE_COLUMNS).eq('id', zoneId).maybeSingle())
      return row ? toZone(row) : null
    },

    // Una sola consulta: filas de zone_analogs con su análogo embebido (FK analog_id -> analogs.id).
    analogsForZone: async (zoneId) => {
      const rows = check<{ analogs: AnalogRow | null }[]>(
        'zone_analogs',
        await db.from('zone_analogs').select(`analogs (${ANALOG_COLUMNS})`).eq('zone_id', zoneId),
      )
      return rows.flatMap((r) => (r.analogs ? [toAnalog(r.analogs)] : []))
    },
  }
}

const source: DataSource = supabase ? createSupabaseSource(supabase) : createSeedSource()
if (import.meta.env.DEV) console.info(`[data] Fuente de datos: ${source.name}`)

// ---------------------------------------------------------------------
// API pública
// ---------------------------------------------------------------------
export function getBodies(): Promise<Body[]> {
  return source.bodies()
}

export function getZones(bodyId: BodyId): Promise<Zone[]> {
  return source.zones(bodyId)
}

export function getZone(zoneId: string): Promise<Zone | null> {
  return source.zone(zoneId)
}

export function emptyAnalogsByCategory(): AnalogsByCategory {
  return Object.fromEntries(CATEGORY_IDS.map((c) => [c, []])) as unknown as AnalogsByCategory
}

export async function getAnalogsForZone(zoneId: string): Promise<AnalogsByCategory> {
  const grouped = emptyAnalogsByCategory()
  for (const analog of await source.analogsForZone(zoneId)) {
    if (grouped[analog.category]) grouped[analog.category].push(analog)
    else console.warn(`Análogo ${analog.id} con categoría desconocida: ${analog.category}`)
  }
  for (const c of CATEGORY_IDS) grouped[c].sort((a, b) => a.name.localeCompare(b.name, 'es'))
  return grouped
}
