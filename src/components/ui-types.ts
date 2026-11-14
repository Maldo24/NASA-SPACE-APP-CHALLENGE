import type { Category } from '../config/categories'

// Tipos mínimos de presentación mientras C define types/domain.ts.
// No reemplazan el modelo relacional ni añaden campos a los datos.
export interface AnalogData {
  id: string
  name: string
  category: Category
  lat: number
  lon: number
  why: string
  image: string
  source: string
}

export interface ZoneSummary {
  properties: {
    id: string
    name: string
    zoneType: string
    description: string
  }
}

export type GroupedAnalogs = Partial<Record<Category, AnalogData[]>>
