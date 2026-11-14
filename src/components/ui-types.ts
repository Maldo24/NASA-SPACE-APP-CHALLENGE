// Tipos de presentación. Ahora apuntan a los tipos del dominio (types/domain.ts, dueño C),
// que son los que devuelve lib/data.ts. Se mantienen estos nombres para no tocar los componentes.
import type { Analog, AnalogsByCategory, Zone } from '../types/domain'

/** Análogo tal como lo devuelve data.ts. `image` y `source` pueden ser null (pendientes). */
export type AnalogData = Analog

/** Zona seleccionada en el mapa. */
export type ZoneSummary = Zone

export type GroupedAnalogs = Partial<AnalogsByCategory>
