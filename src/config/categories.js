// Las 4 categorías de análogos. El campo `category` en analogs.json usa estas keys.
export const CATEGORIES = {
  geomorphological: {
    label: 'Geomorfológico',
    short: 'Geo',
    description: 'La forma del relieve se parece (cráteres, canales, dunas).',
  },
  mineralogical: {
    label: 'Mineralógico / Geoquímico',
    short: 'Min',
    description: 'Las rocas o minerales son los mismos (basaltos, arcillas, sulfatos, percloratos).',
  },
  environmental: {
    label: 'Ambiental / Habitabilidad',
    short: 'Amb',
    description: 'Condiciones extremas parecidas (frío, aridez, UV, salinidad). Sirven para estudiar la vida.',
  },
  operational: {
    label: 'Operacional',
    short: 'Op',
    description: 'Entrenamiento de astronautas y pruebas de rovers, trajes y hábitats.',
  },
}

export const CATEGORY_KEYS = Object.keys(CATEGORIES)
