-- Análogos terrestres.
-- * source: enlace real verificado (responde HTTP 200 o redirige). NULL = pendiente.
--   Los enlaces de Wikipedia solo respaldan la ubicación y descripción general del sitio;
--   conviene reemplazarlos por publicaciones científicas cuando se encuentren.
-- * image: NULL = foto pendiente (ver public/img/analogs/README.md).
-- * Los textos "why" siguen CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md (secciones 4–7 y 12).
-- * Un mismo sitio puede tener una fila por categoría (ej. haughton y haughton-hmp).
insert into public.analogs (id, name, category, lat, lon, why, image, source) values
  -- ---------- Bolivia y Andes ----------
  ('uyuni', 'Salar de Uyuni, Bolivia', 'mineralogical', -20.13, -67.49,
   'Evaporitas, salmueras y costras salinas útiles para comparar depósitos de cloruros y sales marcianos. No se le atribuyen percloratos sin análisis local.',
   null, 'https://science.nasa.gov/earth/earth-observatory/bolivian-salt-flats-151813/'),
  ('licancabur', 'Volcán Licancabur y lagunas de altura, Bolivia–Chile', 'environmental', -22.83, -67.88,
   'Lagos de altura con frío, alta radiación UV y organismos adaptados, estudiados en el proyecto High-Lakes. Es un análogo de ambientes lacustres antiguos, no del Marte actual completo.',
   null, 'https://doi.org/10.1029/2008JG000818'),
  ('torotoro', 'Parque Nacional Torotoro, Bolivia', 'operational', -18.13, -65.76,
   'Estratos, cañones y contactos sedimentarios para entrenar lectura estratigráfica e interpretación de imágenes. Analogía metodológica: no reproduce el origen tectónico de Valles Marineris.',
   null, 'https://en.wikipedia.org/wiki/Torotoro_National_Park'),
  ('sajama', 'Volcán Sajama, Bolivia', 'operational', -18.11, -68.88,
   'Terreno volcánico de altura, pendientes y frío para probar arranque de baterías, estabilidad y procedimientos de campo de rovers. Candidato por procesos, requiere comprobación por sector.',
   null, 'https://en.wikipedia.org/wiki/Nevado_Sajama'),
  ('el-tatio', 'Géiseres de El Tatio, Chile', 'mineralogical', -22.33, -68.01,
   'Campo hidrotermal de altura con depósitos de sílice, comparable con los depósitos hidrotermales de Home Plate y relevante para la preservación de biofirmas.',
   null, 'https://en.wikipedia.org/wiki/El_Tatio'),
  ('atacama', 'Desierto de Atacama, Chile', 'environmental', -24.5, -69.25,
   'Uno de los lugares más áridos de la Tierra, con sales y alta radiación UV. Se usa para estudiar los límites de la vida en condiciones de extrema sequedad.',
   null, 'https://en.wikipedia.org/wiki/Atacama_Desert'),

  -- ---------- Resto del mundo ----------
  ('rio-tinto', 'Río Tinto, España', 'mineralogical', 37.69, -6.59,
   'Aguas ácidas ricas en hierro con sulfatos de hierro, comparables con los sulfatos y la alteración química de Meridiani Planum.',
   null, 'https://en.wikipedia.org/wiki/Rio_Tinto_(river)'),
  ('salda', 'Lago Salda, Turquía', 'mineralogical', 37.55, 29.68,
   'Lago con carbonatos y sedimentos que se compara con el antiguo lago y delta del cráter Jezero.',
   null, 'https://en.wikipedia.org/wiki/Lake_Salda'),
  ('kilauea', 'Kīlauea, Hawái, EE.UU.', 'mineralogical', 19.41, -155.28,
   'Volcán en escudo de basalto. Sus coladas sirven para comparar los basaltos de los mares lunares y los volcanes de Tharsis.',
   null, 'https://en.wikipedia.org/wiki/K%C4%ABlauea'),
  ('grand-canyon', 'Gran Cañón, EE.UU.', 'geomorphological', 36.1, -112.1,
   'Cañón con paredes estratificadas expuestas. Se parece en forma y capas a Valles Marineris, aunque a una escala mucho menor y con otro origen (erosión fluvial, no tectónica).',
   null, 'https://en.wikipedia.org/wiki/Grand_Canyon'),
  ('meteor-crater', 'Meteor Crater, Arizona, EE.UU.', 'geomorphological', 35.03, -111.02,
   'Cráter de impacto simple y bien conservado, con borde elevado y eyecta. Referencia clásica para comparar cráteres lunares y marcianos.',
   null, 'https://en.wikipedia.org/wiki/Meteor_Crater'),
  ('haughton', 'Cráter Haughton, isla Devon, Canadá', 'geomorphological', 75.38, -89.68,
   'Cráter de impacto en un ambiente polar, frío y seco, útil para estudiar eyecta, erosión e hidrotermalismo de impacto.',
   null, 'https://en.wikipedia.org/wiki/Haughton_impact_crater'),
  ('haughton-hmp', 'Haughton-Mars Project, isla Devon, Canadá', 'operational', 75.43, -89.82,
   'Campamento de investigación donde se ensayan exploración humana y robótica, vehículos y procedimientos de campo en condiciones polares.',
   null, 'https://en.wikipedia.org/wiki/Haughton%E2%80%93Mars_Project'),
  ('mdrs', 'Mars Desert Research Station, Utah, EE.UU.', 'operational', 38.41, -110.79,
   'Estación de simulación de misiones tripuladas a Marte en un terreno sedimentario árido cerca de Hanksville.',
   null, 'https://mdrs.marssociety.org/'),
  ('hi-seas', 'HI-SEAS, Mauna Loa, Hawái, EE.UU.', 'operational', 19.6, -155.48,
   'Hábitat de simulación sobre terreno volcánico para estudiar aislamiento, operaciones y trabajo de tripulaciones.',
   null, 'https://en.wikipedia.org/wiki/HI-SEAS'),
  ('basalt', 'NASA BASALT, Craters of the Moon, Idaho, EE.UU.', 'operational', 43.42, -113.52,
   'Proyecto de NASA que combina exploración geológica en terreno basáltico con decisiones científicas y comunicaciones demoradas.',
   null, 'https://www.nasa.gov/missions/analog-field-testing/what-is-basalt/'),
  ('lanzarote-pangaea', 'Lanzarote, España (ESA PANGAEA)', 'operational', 29.0, -13.6,
   'Entrenamiento geológico de astronautas de la ESA en terreno volcánico y tubos de lava.',
   null, 'https://www.esa.int/Science_Exploration/Human_and_Robotic_Exploration/CAVES_and_Pangaea/What_is_PANGAEA'),
  ('mcmurdo', 'Valles Secos de McMurdo, Antártida', 'environmental', -77.5, 162.0,
   'Desierto polar muy frío y seco con suelos congelados y polígonos. Se compara con el hielo subsuperficial de las llanuras marcianas y con el frío extremo de los polos.',
   null, 'https://en.wikipedia.org/wiki/McMurdo_Dry_Valleys'),
  ('concordia', 'Estación Concordia, Antártida', 'operational', -75.1, 123.33,
   'Base en la meseta antártica usada para estudiar aislamiento prolongado, frío y oscuridad, como en una misión de larga duración.',
   null, 'https://en.wikipedia.org/wiki/Concordia_Station')
on conflict (id) do update set
  name = excluded.name, category = excluded.category, lat = excluded.lat, lon = excluded.lon,
  why = excluded.why, image = excluded.image, source = excluded.source;
