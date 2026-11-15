// Persona A. Costo ESTIMADO de los entrenamientos de un análogo, por astronauta o por rover.
// Modelo y fuentes: docs/COSTOS-ENTRENAMIENTOS.md. Son estimaciones de orden de magnitud:
// no incluyen sueldos, seguros, ni construir o enviar el rover.
// Supuesto base: los astronautas salen de Houston, así que todo sitio (también Bolivia) es un viaje.
import type { Analog, AnalogTraining } from '../types/domain'

type Range = [number, number]

// ---------------------------------------------------------------- regiones
// Pasaje ida y vuelta desde Houston, gasto diario (alojamiento + comida) y transporte local por persona y día (US$).
// Bolivia: viáticos del Departamento de Estado de EE.UU. (La Paz 238, Potosí 152, resto 130) y tour compartido (75).
// EE.UU.: viático estándar de GSA (178). El resto de las regiones y todo el transporte local son estimaciones.
interface Region { label: string; flight: Range; perDay: Range; local: number }
const REGION = {
  bolivia: { label: 'Bolivia', flight: [1800, 2000], perDay: [75, 130], local: 0 }, // el 4x4 ya va en los 75 del tour
  arizona: { label: 'Arizona (aeropuerto de Flagstaff)', flight: [400, 800], perDay: [178, 178], local: 25 },
  idaho: { label: 'Idaho (aeropuerto de Idaho Falls)', flight: [500, 900], perDay: [178, 178], local: 25 },
  utah: { label: 'Utah (aeropuerto de Grand Junction)', flight: [450, 850], perDay: [178, 178], local: 25 },
  hawai: { label: 'Hawái (aeropuerto de Hilo)', flight: [800, 1400], perDay: [250, 350], local: 30 },
  chile: { label: 'Chile (aeropuerto de Calama)', flight: [1200, 2000], perDay: [150, 250], local: 40 },
  canada: { label: 'Labrador, Canadá', flight: [1500, 3000], perDay: [200, 300], local: 60 },
  artico: { label: 'isla Devon, Ártico canadiense', flight: [3000, 6000], perDay: [250, 400], local: 150 },
  europa: { label: 'Europa', flight: [1200, 2000], perDay: [200, 300], local: 30 },
  asia: { label: 'Asia', flight: [2000, 3500], perDay: [150, 300], local: 60 },
} satisfies Record<string, Region>
type RegionId = keyof typeof REGION

// ---------------------------------------------------------------- sitios fuera de Bolivia
// extraDays: días de traslado por tierra, avioneta o barco además de los 2 de vuelo.
// fee: entrada por persona (US$). Si la tarifa es por vehículo se divide entre 3 personas.
interface Site { region: RegionId | 'antartida'; extraDays?: number; fee?: number; feeLabel?: string }
const SITES: Record<string, Site> = {
  'cinder-lake': { region: 'arizona' },
  'sp-mountain': { region: 'arizona' },
  'lava-river-cave-az': { region: 'arizona' },
  'meteor-crater': { region: 'arizona', fee: 29, feeLabel: 'Entrada a Meteor Crater: US$ 29 por persona' },
  'grand-canyon': { region: 'arizona', fee: 12, feeLabel: 'Entrada al Gran Cañón: US$ 35 por vehículo' },
  basalt: { region: 'idaho', fee: 7, feeLabel: 'Entrada a Craters of the Moon: hasta US$ 20 por vehículo' },
  mdrs: { region: 'utah', extraDays: 1 },
  kilauea: { region: 'hawai', fee: 10, feeLabel: 'Entrada a Hawaiʻi Volcanoes: US$ 30 por vehículo' },
  'mauna-kea-isru': { region: 'hawai' },
  'hi-seas': { region: 'hawai' },
  atacama: { region: 'chile', extraDays: 1 },
  'el-tatio': { region: 'chile', extraDays: 1 },
  mistastin: { region: 'canada', extraDays: 2 }, // avioneta desde Goose Bay
  haughton: { region: 'artico', extraDays: 2 }, // vuelo chárter desde Resolute
  'haughton-hmp': { region: 'artico', extraDays: 2 },
  'lanzarote-pangaea': { region: 'europa', fee: 33, feeLabel: 'Entrada a Timanfaya: € 30 por persona' },
  'ries-crater': { region: 'europa' },
  'rio-tinto': { region: 'europa' },
  salda: { region: 'europa', extraDays: 1 },
  qaidam: { region: 'asia', extraDays: 1 },
  tolbachik: { region: 'asia', extraDays: 2 },
  yakutia: { region: 'asia', extraDays: 1 },
  concordia: { region: 'antartida' },
  mcmurdo: { region: 'antartida' },
}

// ---------------------------------------------------------------- Bolivia
// Días de ida y vuelta desde La Paz y departamento (para el viático máximo).
// Antes de salir al campo: 2 días de aclimatación a la altura en La Paz.
const ACCLIMATION = 2
const LA_PAZ_PER_DAY: Range = [75, 238]
const BO_DEPT_MAX: Record<string, number> = { lapaz: 238, potosi: 152, otro: 130 }
const BO: Record<string, { travel: number; dept: keyof typeof BO_DEPT_MAX; fee?: number; feeLabel?: string }> = {
  'valle-de-la-luna': { travel: 0, dept: 'lapaz' },
  'cordillera-real': { travel: 0, dept: 'lapaz' },
  sajama: { travel: 2, dept: 'otro' },
  'sajama-hielo': { travel: 2, dept: 'otro' },
  'permafrost-occidental': { travel: 2, dept: 'otro' },
  'lago-tauca': { travel: 2, dept: 'otro' },
  'lago-poopo': { travel: 2, dept: 'otro' },
  coipasa: { travel: 2, dept: 'otro' },
  'tata-sabaya': { travel: 2, dept: 'otro' },
  'salares-capas': { travel: 2, dept: 'potosi' },
  uyuni: { travel: 2, dept: 'potosi' },
  intersalar: { travel: 2, dept: 'potosi' },
  'cerro-rico': { travel: 2, dept: 'potosi' },
  torotoro: { travel: 2, dept: 'potosi' },
  umajalanta: { travel: 2, dept: 'potosi' },
  'italia-perdida': { travel: 3, dept: 'potosi' },
  guapore: { travel: 3, dept: 'otro' },
  iturralde: { travel: 3, dept: 'lapaz' },
}
const REA_FEE = { fee: 22, feeLabel: 'Entrada a la Reserva Eduardo Avaroa: Bs 150 por persona' }
for (const id of ['laguna-blanca-termal', 'laguna-colorada', 'laguna-verde', 'siloli', 'sol-de-manana', 'sud-lipez', 'desierto-dali', 'licancabur']) BO[id] = { travel: 3, dept: 'potosi', ...REA_FEE }
for (const id of ['canapa', 'glaciares-roca', 'la-salsa', 'ollague', 'pastos-grandes', 'tajzara']) BO[id] = { travel: 3, dept: 'potosi' }

// ---------------------------------------------------------------- días en el sitio según la actividad
const DESK = /en imágenes|imágenes (orbitales|repetidas|y|de)|modelo digital|modelo de elevación|mapas? de elevación|datos publicados|publicad|archivos|espectros|conjunto etiquetado|perfiles|muestras artificiales|registros fechados|reconstruir cambios|cartografiar|delimitar|clasificar imágenes|interpretar imágenes|réplica|mapa de imágenes/i
const PHOTO_TRIP = /con fotografías autorizadas/i
const isField = (t: AnalogTraining) =>
  t.audience === 'habitats' || PHOTO_TRIP.test(t.activity) || !(/contrastar fotografías y análisis/i.test(t.activity) || DESK.test(t.activity))

function siteDays(t: AnalogTraining): Range {
  const s = t.activity
  if (t.audience === 'habitats') return [14, 14]
  if (PHOTO_TRIP.test(s)) return [1, 2] // salida para tomar fotos
  if (/monitorear|serie de mediciones|registradores|sondeos|propiedades térmicas|regiones especiales/i.test(s)) return [3, 5] // instalar y leer instrumentos
  if (/probetas|tejido o recubrimiento|exposición/i.test(s)) return [3, 5] // exponer muestras y recuperarlas
  if (/travesía|campaña/i.test(s)) return [2, 3]
  if (t.audience === 'rovers') return /cooperación|coordinar/i.test(s) ? [2, 3] : [3, 5]
  if (/salida geológica|seleccionar y documentar|estaciones/i.test(s)) return [2, 3]
  return [1, 2] // observación o reconocimiento corto
}
const sumDays = (ts: AnalogTraining[]): Range => ts.reduce<Range>((acc, t) => { const d = siteDays(t); return [acc[0] + d[0], acc[1] + d[1]] }, [0, 0])

export const ROVER_OPERATORS = 3
const STATION_FEE: Record<string, Range> = { mdrs: [2250, 3750] } // cuota de MDRS por persona (dato público)

// ---------------------------------------------------------------- resultado
export interface CostBreakdown {
  flight: Range
  perDiem: Range
  fees: Range
  total: Range
  daysAway: Range
  siteDays: Range
}

export type CostEstimate =
  | { kind: 'desk' }
  | { kind: 'unknown' }
  | { kind: 'mission'; text: string }
  | { kind: 'field'; regionLabel: string; notes: string[]; perAstronaut: CostBreakdown | null; perRover: CostBreakdown | null }

interface Trip { flight: Range; perDay: Range; local: number; extraDays: number; fixedDays: { days: number; perDay: Range }[]; fee: Range }

function breakdown(trip: Trip, site: Range, people: number): CostBreakdown {
  const away: Range = [site[0] + trip.extraDays + trip.fixedDays.reduce((s, f) => s + f.days, 0), site[1] + trip.extraDays + trip.fixedDays.reduce((s, f) => s + f.days, 0)]
  const daily = (i: 0 | 1) => (trip.perDay[i] + trip.local) * (site[i] + trip.extraDays) + trip.fixedDays.reduce((s, f) => s + f.perDay[i] * f.days, 0)
  const flight: Range = [trip.flight[0] * people, trip.flight[1] * people]
  const perDiem: Range = [daily(0) * people, daily(1) * people]
  const fees: Range = [trip.fee[0] * people, trip.fee[1] * people]
  return { flight, perDiem, fees, total: [flight[0] + perDiem[0] + fees[0], flight[1] + perDiem[1] + fees[1]], daysAway: away, siteDays: site }
}

export function estimateTrainingCost(analog: Analog): CostEstimate {
  const field = analog.trainings.filter(isField)
  if (analog.id === 'hi-seas') return { kind: 'mission', text: '≈ US$ 400.000 por misión de 4 a 12 meses (NASA dio US$ 1,2 millones para 3 misiones), más los pasajes a Hawái.' }
  if (!field.length) return { kind: 'desk' }

  const notes: string[] = []
  let trip: Trip
  let regionLabel: string
  const bo = /Bolivia/.test(analog.name) ? BO[analog.id] : undefined
  if (bo) {
    const r = REGION.bolivia
    regionLabel = r.label
    trip = {
      flight: r.flight, perDay: [r.perDay[0], BO_DEPT_MAX[bo.dept]], local: 0, extraDays: bo.travel,
      fixedDays: [{ days: ACCLIMATION, perDay: LA_PAZ_PER_DAY }], fee: [bo.fee ?? 0, bo.fee ?? 0],
    }
    notes.push(`Incluye ${ACCLIMATION} días de aclimatación a la altura en La Paz${bo.travel ? ` y ${bo.travel} días de ida y vuelta por tierra` : ''}.`)
    if (bo.feeLabel) notes.push(bo.feeLabel + '.')
  } else {
    const site = SITES[analog.id]
    if (!site || site.region === 'antartida') return { kind: 'unknown' }
    const r = REGION[site.region]
    regionLabel = r.label
    const fee: Range = STATION_FEE[analog.id] ?? [site.fee ?? 0, site.fee ?? 0]
    trip = { flight: r.flight, perDay: r.perDay, local: r.local, extraDays: 2 + (site.extraDays ?? 0), fixedDays: [], fee }
    if (site.extraDays) notes.push(`Incluye ${site.extraDays} día${site.extraDays > 1 ? 's' : ''} extra de traslado hasta el sitio.`)
    if (site.feeLabel) notes.push(site.feeLabel + '.')
    if (STATION_FEE[analog.id]) notes.push('Cuota de la estación: US$ 2.000–3.500 por persona, más depósito.')
  }

  const people = field.filter((t) => t.audience !== 'rovers')
  const rovers = field.filter((t) => t.audience === 'rovers')
  return {
    kind: 'field', regionLabel, notes,
    // En un hábitat, las salidas y prácticas se hacen dentro de la misma estadía de 2 semanas.
    perAstronaut: people.length ? breakdown(trip, people.some((t) => t.audience === 'habitats') ? [14, 14] : sumDays(people), 1) : null,
    perRover: rovers.length ? breakdown(trip, sumDays(rovers), ROVER_OPERATORS) : null,
  }
}
