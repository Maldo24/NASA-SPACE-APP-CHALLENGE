export const CATEGORIES = {
  geomorphological: {
    label: 'Geomorfológico', short: 'Relieve', number: '01',
    description: 'Compara formas del relieve: cráteres, cañones, dunas y llanuras. Una forma parecida puede tener un origen diferente.',
  },
  mineralogical: {
    label: 'Mineralógico / geoquímico', short: 'Minerales', number: '02',
    description: 'Compara rocas, minerales y procesos químicos. La semejanza debe respaldarse con análisis del lugar concreto.',
  },
  environmental: {
    label: 'Ambiental / habitabilidad', short: 'Ambiente', number: '03',
    description: 'Compara aspectos como frío, aridez, radiación UV y salinidad. Ningún sitio terrestre reproduce todo el ambiente planetario.',
  },
  operational: {
    label: 'Operacional', short: 'Operaciones', number: '04',
    description: 'Explora lugares para practicar geología y procedimientos o ensayar rovers. Su utilidad no implica que las condiciones físicas sean iguales.',
  },
} as const

export type Category = keyof typeof CATEGORIES
export const CATEGORY_KEYS = Object.keys(CATEGORIES) as Category[]
