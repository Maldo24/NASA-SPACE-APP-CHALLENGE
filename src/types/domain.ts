// Tipos del dominio — Análogos Planetarios (dueño: C).
// Reflejan supabase/migrations/20261114000000_esquema_inicial.sql.
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
  description: string
  geometry: Polygon
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
}

/** Lo que devuelve getAnalogsForZone(zoneId): análogos agrupados por categoría.
 *  Siempre trae las 4 claves; una categoría sin análogos es un array vacío. */
export type AnalogsByCategory = Record<Category, Analog[]>
