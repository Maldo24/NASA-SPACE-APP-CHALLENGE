// Tipos del dominio — Análogos Planetarios (dueño: C).
// Reflejan supabase/migrations/ (esquema inicial, analogías y quiebre, profundización).
//
// Hay dos capas:
//   1. *Row  -> filas tal como vienen de Supabase (snake_case).
//   2. Body, Zone, Analog -> lo que usan los componentes (camelCase).
// src/lib/data.ts (dueño: A) convierte de Row a dominio. Los componentes solo ven la capa 2.

// ---------------------------------------------------------------------
// Valores fijos
// ---------------------------------------------------------------------
export type BodyId = 'moon' | 'mars'

export type Category =
  | 'geomorphological' // la forma del relieve se parece
  | 'mineralogical'    // rocas o minerales parecidos
  | 'environmental'    // condiciones extremas parecidas (habitabilidad)
  | 'operational'      // entrenar astronautas, probar rovers, trajes y hábitats

/** Lista ordenada de categorías (para iterar en pestañas, validaciones, etc.). */
export const CATEGORY_IDS: readonly Category[] = [
  'geomorphological',
  'mineralogical',
  'environmental',
  'operational',
] as const

/** Para quién es un entrenamiento (tabla analog_trainings). */
export type TrainingAudience = 'astronauts' | 'rovers' | 'suits' | 'habitats' | 'science'

export const TRAINING_AUDIENCES: readonly TrainingAudience[] = [
  'astronauts',
  'rovers',
  'suits',
  'habitats',
  'science',
] as const

// ---------------------------------------------------------------------
// GeoJSON mínimo (sin dependencia de @types/geojson)
// ---------------------------------------------------------------------
/** [lon, lat] con lon entre -180 y 180. */
export type Position = [lon: number, lat: number]

export interface Polygon {
  type: 'Polygon'
  /** Anillo exterior primero; cada anillo cerrado (primer punto = último). */
  coordinates: Position[][]
}

// ---------------------------------------------------------------------
// Capa 1: filas de Supabase (snake_case)
// ---------------------------------------------------------------------
export interface BodyRow {
  id: BodyId
  name: string
  layer_url: string
  attribution: string
  max_zoom: number
}

export interface ZoneRow {
  id: string // ej. 'mars-jezero'; el prefijo coincide con body_id
  body_id: BodyId
  name: string
  zone_type: string
  description: string
  geometry: Polygon
  geology: string | null      // null = pendiente
  environment: string | null
  exploration: string | null
  importance: string | null
  sources: string[]
}

export interface AnalogAspectRow {
  analog_id: string
  category: Category
  covers: string
  breaks: string
  source: string | null
}

export interface AnalogTrainingRow {
  analog_id: string
  position: number
  audience: TrainingAudience
  activity: string
  measures: string
  restrictions: string | null
  source: string | null
}

export interface AnalogRow {
  id: string
  name: string
  category: Category
  lat: number
  lon: number
  why: string
  image: string | null  // null = foto pendiente
  source: string | null // null = fuente pendiente
  secondary_categories: Category[] // otras analogías que cumple en parte (sin la principal)
  breaking_point: string | null    // lo que no llega a representar. null = pendiente
  // Embebidos por Supabase a través de las FK (pueden faltar si no se piden en el select)
  analog_aspects?: Omit<AnalogAspectRow, 'analog_id'>[]
  analog_trainings?: Omit<AnalogTrainingRow, 'analog_id'>[]
}

export interface ZoneAnalogRow {
  zone_id: string
  analog_id: string
}

// ---------------------------------------------------------------------
// Capa 2: dominio que consumen los componentes (camelCase)
// ---------------------------------------------------------------------
export interface Body {
  id: BodyId
  name: string
  layerUrl: string
  attribution: string
  maxZoom: number
}

export interface Zone {
  id: string
  bodyId: BodyId
  name: string
  zoneType: string
  /** Resumen de 1–2 frases. */
  description: string
  geometry: Polygon
  /** Ficha de la zona (tarea 2). Cada campo null = pendiente. */
  geology: string | null
  environment: string | null
  exploration: string | null
  importance: string | null
  /** URLs que respaldan la ficha. */
  sources: string[]
}

/** Qué reproduce un análogo en un tipo de analogía y dónde se rompe (tarea 1). */
export interface AnalogAspect {
  category: Category
  covers: string
  breaks: string
  /** Respaldo específico. null = vale la fuente del análogo. */
  source: string | null
}

/** Una actividad de entrenamiento o prueba posible en el análogo (tarea 3). */
export interface AnalogTraining {
  audience: TrainingAudience
  activity: string
  measures: string
  restrictions: string | null
  /** Respaldo específico. null = vale la fuente del análogo. */
  source: string | null
}

export interface Analog {
  id: string
  name: string
  category: Category
  lat: number
  lon: number
  why: string
  /** Ruta relativa a public/, ej. 'img/analogs/uyuni.jpg'. null = foto pendiente. */
  image: string | null
  /** URL real de la fuente. null = fuente pendiente (mostrar "Fuente pendiente"). */
  source: string | null
  /** Otras analogías que cumple en parte. La principal, a la que más se acerca, es `category`. */
  secondaryCategories: Category[]
  /** Punto de quiebre: lo que el sitio no llega a representar. null = pendiente. */
  breakingPoint: string | null
  /** Límites por tipo de analogía, en el orden de CATEGORY_IDS. Vacío = pendiente.
   *  Las categorías que no aparecen son las que el análogo no cubre. */
  aspects: AnalogAspect[]
  /** Entrenamientos posibles, en orden. Vacío = pendiente. */
  trainings: AnalogTraining[]
}

/** Lo que devuelve getAnalogsForZone(zoneId): análogos agrupados por categoría.
 *  Siempre trae las 4 claves; una categoría sin análogos es un array vacío. */
export type AnalogsByCategory = Record<Category, Analog[]>
