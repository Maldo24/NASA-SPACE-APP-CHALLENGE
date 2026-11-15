// Textos de la interfaz en español e inglés.
// `en` tiene el mismo tipo que `es`: si falta una clave en inglés, el proyecto no compila.
// Los textos de contenido (zonas y análogos) no van aquí: ver src/i18n/content.ts.
import type { Category, TrainingAudience } from '../types/domain'

const es = {
  langSwitch: { group: 'Idioma / Language', es: 'Español', en: 'English' },
  bodies: { moon: 'Luna', mars: 'Marte', nav: 'Cuerpo celeste' },
  map: { loading: (body: string) => `Cargando ${body.toLowerCase()}…` },

  categories: {
    geomorphological: {
      label: 'Geomorfológico', short: 'Relieve',
      description: 'Compara formas del relieve: cráteres, cañones, dunas y llanuras. Una forma parecida puede tener un origen diferente.',
    },
    mineralogical: {
      label: 'Mineralógico / geoquímico', short: 'Minerales',
      description: 'Compara rocas, minerales y procesos químicos. La semejanza debe respaldarse con análisis del lugar concreto.',
    },
    environmental: {
      label: 'Ambiental / habitabilidad', short: 'Ambiente',
      description: 'Compara aspectos como frío, aridez, radiación UV y salinidad. Ningún sitio terrestre reproduce todo el ambiente planetario.',
    },
    operational: {
      label: 'Operacional', short: 'Operaciones',
      description: 'Explora lugares para practicar geología y procedimientos o ensayar rovers. Su utilidad no implica que las condiciones físicas sean iguales.',
    },
  } satisfies Record<Category, { label: string; short: string; description: string }>,

  audiences: {
    astronauts: 'Astronautas', rovers: 'Rovers', suits: 'Trajes', habitats: 'Hábitats', science: 'Ciencia',
  } satisfies Record<TrainingAudience, string>,

  welcome: {
    kicker: 'Explorador planetario',
    eyebrow: 'Luna · Marte · Tierra',
    title: 'Otros mundos,',
    titleAccent: 'terrenos en común.',
    description: 'Descubre qué lugares de la Tierra ayudan a estudiar y explorar la Luna y Marte.',
    steps: [
      { title: 'Elige un mundo', text: 'Usa el selector de Luna y Marte.' },
      { title: 'Selecciona una zona', text: 'Toca un área delimitada en el mapa.' },
      { title: 'Compara sus análogos', text: 'Explora relieve, minerales, ambiente y operaciones.' },
    ],
    note: 'Cada análogo comparte aspectos concretos. Ningún lugar terrestre reproduce por completo otro mundo.',
  },

  panel: {
    selected: 'Zona seleccionada',
    loading: 'Cargando análogos…',
    analogCount: (n: number): string => (n === 1 ? 'análogo terrestre' : 'análogos terrestres'),
    categoryCount: '4 categorías',
    tabsLabel: 'Tipo de analogía',
    tabLabel: (category: string, n: number) => `${category}, ${n} ${n === 1 ? 'análogo' : 'análogos'}`,
    emptyTitle: 'Aún no hay análogos en esta categoría',
    emptyText: 'Prueba otra pestaña para explorar los lugares disponibles para esta zona.',
    note: 'Las semejanzas son parciales. Consulta la fuente de cada lugar para conocer su alcance.',
  },

  zoneFacts: {
    pending: 'Ficha detallada de la zona: pendiente.',
    summary: 'Ficha de la zona',
    geology: 'Geología',
    environment: 'Ambiente',
    exploration: 'Exploración',
    importance: 'Por qué interesa',
    sources: 'Fuentes:',
  },

  card: { info: 'Información' },
  photo: {
    alt: (name: string) => `Paisaje de ${name}`,
    unavailable: 'Fotografía no disponible',
    pending: 'Fotografía pendiente',
  },
  newTab: '(abre en otra pestaña)',

  detail: {
    backToMap: '← Volver al mapa',
    backTo: (zone: string) => `← Volver a ${zone}`,
    loading: 'Cargando información del análogo…',
    notFoundTitle: 'Análogo no encontrado',
    notFoundText: 'Este enlace no corresponde a un análogo de esta zona. Selecciona un lugar desde el mapa.',
    errorTitle: 'No se pudo cargar la información',
    errorText: 'Revisa tu conexión y vuelve a intentarlo.',
    retry: 'Reintentar',
    analogOf: (zone: string, body: string) => `Análogo de ${zone} · ${body}`,
    why: 'Por qué se parece',
    categories: 'Analogías que cumple',
    main: 'Principal',
    partial: 'También cumple en parte',
    breakingPoint: 'Punto de quiebre',
    pendingAnalysis: 'Pendiente de analizar.',
    sidebar: 'Ubicación y fuente del análogo',
    location: 'Ubicación en la Tierra',
    locationPending: 'Ubicación pendiente de confirmar.',
    source: 'Fuente',
    sourceLink: 'Consultar fuente',
    sourceOf: (name: string) => ` de ${name} (abre en otra pestaña)`,
    sourcePending: 'Fuente pendiente de verificar',
  },

  aspects: {
    title: 'Qué cubre y dónde se rompe',
    pending: 'Análisis por tipo de analogía: pendiente.',
    covers: 'Reproduce',
    breaks: 'Se rompe',
    source: 'Fuente',
    notCovered: 'No cubre:',
  },

  trainings: {
    title: 'Entrenamiento posible',
    pending: 'Entrenamiento posible: pendiente.',
    measures: 'Se mide:',
    restrictions: 'Restricciones:',
    source: 'Fuente',
  },

  costs: {
    title: 'Costo estimado de entrenar aquí',
    desk: 'Sus entrenamientos se hacen con imágenes, modelos digitales o datos publicados, sin viajar.',
    deskCost: 'Costo directo: casi US$ 0.',
    unknown: 'Requiere logística polar o de difícil acceso. No hay datos públicos para estimar el costo.',
    unitGroup: 'Calcular el costo',
    perAstronaut: 'Por astronauta',
    perRover: 'Por rover',
    noRover: 'Este análogo no tiene pruebas de rovers en el campo.',
    noPeople: 'Este análogo no tiene entrenamientos de campo para personas; solo de rovers.',
    total: 'Costo estimado',
    daysAway: 'Días fuera de casa',
    flightShare: 'Parte del pasaje',
    parts: {
      flight: 'Pasaje desde Houston',
      perDiem: 'Viáticos y transporte local',
      fees: 'Entradas o cuota de la estación',
    },
    travelFrom: (region: string) => `Viaje desde Houston a ${region}.`,
    siteDays: (days: string, rover: boolean) =>
      `${days} días de trabajo en el sitio para hacer todos sus entrenamientos de campo${rover ? ' con rovers' : ''}.`,
    roverTeam: (n: number) => `Por rover se supone un equipo de ${n} operadores; no incluye construir ni enviar el rover.`,
    disclaimer: 'Estimación de orden de magnitud con viáticos y pasajes públicos de referencia. No incluye sueldos ni seguros: el costo real sería mayor.',
  },
}

export type UiStrings = typeof es

const en: UiStrings = {
  langSwitch: { group: 'Idioma / Language', es: 'Español', en: 'English' },
  bodies: { moon: 'Moon', mars: 'Mars', nav: 'Celestial body' },
  map: { loading: (body: string) => `Loading the ${body}…` },

  categories: {
    geomorphological: {
      label: 'Geomorphological', short: 'Landforms',
      description: 'Compares landforms: craters, canyons, dunes and plains. A similar shape can have a different origin.',
    },
    mineralogical: {
      label: 'Mineralogical / geochemical', short: 'Minerals',
      description: 'Compares rocks, minerals and chemical processes. The similarity must be backed by analysis of the specific site.',
    },
    environmental: {
      label: 'Environmental / habitability', short: 'Environment',
      description: 'Compares aspects such as cold, aridity, UV radiation and salinity. No place on Earth reproduces a whole planetary environment.',
    },
    operational: {
      label: 'Operational', short: 'Operations',
      description: 'Places to practice geology and procedures or to test rovers. Being useful does not mean the physical conditions are the same.',
    },
  },

  audiences: {
    astronauts: 'Astronauts', rovers: 'Rovers', suits: 'Suits', habitats: 'Habitats', science: 'Science',
  },

  welcome: {
    kicker: 'Planetary explorer',
    eyebrow: 'Moon · Mars · Earth',
    title: 'Other worlds,',
    titleAccent: 'common ground.',
    description: 'Discover which places on Earth help us study and explore the Moon and Mars.',
    steps: [
      { title: 'Pick a world', text: 'Use the Moon and Mars selector.' },
      { title: 'Select a zone', text: 'Tap an outlined area on the map.' },
      { title: 'Compare its analogs', text: 'Explore landforms, minerals, environment and operations.' },
    ],
    note: 'Each analog shares specific features. No place on Earth fully reproduces another world.',
  },

  panel: {
    selected: 'Selected zone',
    loading: 'Loading analogs…',
    analogCount: (n: number) => (n === 1 ? 'Earth analog' : 'Earth analogs'),
    categoryCount: '4 categories',
    tabsLabel: 'Type of analogy',
    tabLabel: (category: string, n: number) => `${category}, ${n} ${n === 1 ? 'analog' : 'analogs'}`,
    emptyTitle: 'No analogs in this category yet',
    emptyText: 'Try another tab to explore the places available for this zone.',
    note: 'The similarities are partial. Check each place’s source to see how far it goes.',
  },

  zoneFacts: {
    pending: 'Detailed zone profile: pending.',
    summary: 'Zone profile',
    geology: 'Geology',
    environment: 'Environment',
    exploration: 'Exploration',
    importance: 'Why it matters',
    sources: 'Sources:',
  },

  card: { info: 'Details' },
  photo: {
    alt: (name: string) => `Landscape of ${name}`,
    unavailable: 'Photo unavailable',
    pending: 'Photo pending',
  },
  newTab: '(opens in a new tab)',

  detail: {
    backToMap: '← Back to the map',
    backTo: (zone: string) => `← Back to ${zone}`,
    loading: 'Loading analog details…',
    notFoundTitle: 'Analog not found',
    notFoundText: 'This link does not match an analog of this zone. Pick a place from the map.',
    errorTitle: 'The information could not be loaded',
    errorText: 'Check your connection and try again.',
    retry: 'Try again',
    analogOf: (zone: string, body: string) => `Analog of ${zone} · ${body}`,
    why: 'Why it is similar',
    categories: 'Analogies it meets',
    main: 'Main',
    partial: 'Also partly meets',
    breakingPoint: 'Breaking point',
    pendingAnalysis: 'Analysis pending.',
    sidebar: 'Location and source of the analog',
    location: 'Location on Earth',
    locationPending: 'Location to be confirmed.',
    source: 'Source',
    sourceLink: 'View source',
    sourceOf: (name: string) => ` for ${name} (opens in a new tab)`,
    sourcePending: 'Source pending verification',
  },

  aspects: {
    title: 'What it covers and where it breaks',
    pending: 'Analysis by type of analogy: pending.',
    covers: 'Reproduces',
    breaks: 'Breaks',
    source: 'Source',
    notCovered: 'Does not cover:',
  },

  trainings: {
    title: 'Possible training',
    pending: 'Possible training: pending.',
    measures: 'Measured:',
    restrictions: 'Restrictions:',
    source: 'Source',
  },

  costs: {
    title: 'Estimated cost of training here',
    desk: 'Its training is done with images, digital models or published data, without travelling.',
    deskCost: 'Direct cost: almost US$ 0.',
    unknown: 'Requires polar or hard-to-reach logistics. There is no public data to estimate the cost.',
    unitGroup: 'Calculate the cost',
    perAstronaut: 'Per astronaut',
    perRover: 'Per rover',
    noRover: 'This analog has no rover field tests.',
    noPeople: 'This analog has no field training for people; only for rovers.',
    total: 'Estimated cost',
    daysAway: 'Days away from home',
    flightShare: 'Share of the airfare',
    parts: {
      flight: 'Airfare from Houston',
      perDiem: 'Per diem and local transport',
      fees: 'Entrance fees or station fee',
    },
    travelFrom: (region: string) => `Travel from Houston to ${region}.`,
    siteDays: (days: string, rover: boolean) =>
      `${days} days of on-site work to complete all of its field training${rover ? ' with rovers' : ''}.`,
    roverTeam: (n: number) => `Per rover, a team of ${n} operators is assumed; building or shipping the rover is not included.`,
    disclaimer: 'Order-of-magnitude estimate using public reference per diems and airfares. Salaries and insurance are not included: the real cost would be higher.',
  },
}

export const STRINGS = { es, en } as const
