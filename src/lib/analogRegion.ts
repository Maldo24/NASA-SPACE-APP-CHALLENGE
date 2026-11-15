// Región de un análogo para ordenar la lista: primero Bolivia, luego Latinoamérica y al final el resto
// del mundo. Se deduce del nombre original en español, que siempre termina con el país
// ("Salar de Uyuni, Bolivia", "Desierto de Atacama, Chile"). Los compartidos ("Bolivia–Chile") cuentan
// como Bolivia.

export type AnalogRegion = 'bolivia' | 'latam' | 'world'

const REGION_ORDER: Record<AnalogRegion, number> = { bolivia: 0, latam: 1, world: 2 }

const LATAM = /(?<!\p{L})(Argentina|Brasil|Chile|Colombia|Costa Rica|Cuba|Ecuador|El Salvador|Guatemala|Honduras|México|Nicaragua|Panamá|Paraguay|Perú|Puerto Rico|República Dominicana|Uruguay|Venezuela)(?!\p{L})/u

export function analogRegion(spanishName: string): AnalogRegion {
  if (/(?<!\p{L})Bolivia(?!\p{L})/u.test(spanishName)) return 'bolivia'
  if (LATAM.test(spanishName)) return 'latam'
  return 'world'
}

export function regionRank(spanishName: string): number {
  return REGION_ORDER[analogRegion(spanishName)]
}
