-- Análogos terrestres.
-- * source: enlace real verificado (responde HTTP 200, o el DOI existe en Crossref). NULL = pendiente.
--   Los enlaces de Wikipedia solo respaldan la ubicación y descripción general del sitio;
--   conviene reemplazarlos por publicaciones científicas cuando se encuentren.
-- * image: NULL = foto pendiente (ver public/img/analogs/README.md).
-- * Los textos "why" siguen CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md (secciones 4–7 y 12)
--   y los documentos F2 y F4 (tmp/lectura/). En los sitios bolivianos se indica el nivel de
--   respaldo que les da F4: estudiado, propuesto o sugerido (ver sección 5 del contexto).
-- * "Ubicación aproximada" = la fuente da una región, no un punto.
-- * Un mismo lugar tiene UNA sola fila; sus otros usos van en secondary_categories, analog_aspects
--   y analog_trainings (ej. uyuni). haughton y haughton-hmp son el cráter y la estación, dos sitios distintos.
insert into public.analogs (id, name, category, lat, lon, why, image, source) values

  -- =====================================================================
  -- BOLIVIA
  -- =====================================================================

  -- ---------- Salares de Uyuni y Coipasa ----------
  ('uyuni', 'Salar de Uyuni, Bolivia', 'mineralogical', -20.13, -67.49,
   'Un solo salar que sirve para varias comparaciones con Marte. Sus costras de sal, salmueras y arcillas se parecen a Aureum Chaos (propuesto por la NASA), y sus cloruros se compararon con los de Icaria Planum (UMSA, EPSC 2024). Sus salmueras con litio y magnesio albergan microbios adaptados a la sal (estudiado). Sus polígonos de sal, naturales y de 1–2 m, se forman por convección de la salmuera y no por hielo (Physical Review X, 2023). Su superficie plana y repetitiva sirve para probar la navegación de rovers (propuesta del informe F2). No se le atribuyen percloratos sin análisis local.',
   null, 'https://science.nasa.gov/earth/earth-observatory/bolivian-salt-flats-151813/'),
  ('coipasa', 'Salar de Coipasa, Bolivia', 'mineralogical', -19.38, -68.17,
   'Salar vecino de Uyuni, separado por volcanes. La NASA lo describe, junto con Uyuni, como laboratorio natural para estudiar el ambiente marciano. Permite comparar dos cuencas salinas. Respaldo: estudiado.',
   'img/analogs/coipasa.jpg', 'https://science.nasa.gov/earth/earth-observatory/bolivian-salt-flats-151813/'),
  ('salares-capas', 'Salares de Uyuni y Coipasa, Bolivia — capas', 'geomorphological', -20.13, -67.49,
   'Capas de sal y yeso marcan épocas secas, y capas de barro con microfósiles marcan épocas húmedas. Es un archivo del clima pasado, como las capas del Monte Sharp en el cráter Gale. Respaldo: estudiado.',
   'img/analogs/salares-capas.jpg', 'https://science.nasa.gov/earth/earth-observatory/bolivian-salt-flats-151813/'),
  ('lago-tauca', 'Paleolagos Tauca y Minchin, Altiplano de Bolivia', 'geomorphological', -20.0, -67.6,
   'Grandes lagos del Pleistoceno cuyos restos son hoy los salares. Su nivel subió y bajó mucho: sirven para estudiar cómo quedan registrados esos cambios. Ubicación aproximada. Respaldo: sugerido.',
   'img/analogs/lago-tauca.jpg', 'https://en.wikipedia.org/wiki/Lake_Tauca'),

  -- ---------- Lagos y lagunas de altura ----------
  ('licancabur', 'Volcán Licancabur y lagunas Blanca y Verde, Bolivia–Chile', 'environmental', -22.83, -67.88,
   'Lagos de altura con frío, radiación UV muy alta y organismos adaptados, estudiados por el proyecto High-Lakes como análogos de lagos marcianos antiguos. No representan el Marte actual completo. Respaldo: estudiado.',
   'img/analogs/licancabur.jpg', 'https://doi.org/10.1029/2008JG000818'),
  ('laguna-verde', 'Laguna Verde, Sud Lípez, Bolivia', 'mineralogical', -22.795, -67.825,
   'Terrazas antiguas con microbialitos (rocas construidas por microbios) que registran unos 7.000 años de cambios del lago. Ayudan a entender cómo se secaron los lagos de Marte. Respaldo: estudiado.',
   'img/analogs/laguna-verde.jpg', 'https://en.wikipedia.org/wiki/Laguna_Verde_(Bolivia)'),
  ('pastos-grandes', 'Laguna Pastos Grandes, Sud Lípez, Bolivia', 'mineralogical', -21.75, -67.83,
   'Laguna dentro de una caldera volcánica, alimentada por fuentes termales, con una costra de carbonatos y microbialitos. Se compara con lagos dentro de cráteres con carbonatos, como Jezero. Acceso difícil. Respaldo: estudiado.',
   null, 'https://doi.org/10.3390/geosciences12020088'),
  ('la-salsa', 'Fuente La Salsa, Laguna Pastos Grandes, Bolivia', 'mineralogical', -21.75, -67.83,
   'Montículos hidrotermales de calcio y sílice con microbialitos. Son análogos de depósitos mixtos de carbonato y sílice que pueden conservar señales de vida. Respaldo: estudiado.',
   null, 'https://doi.org/10.3390/min9060380'),
  ('laguna-colorada', 'Laguna Colorada, Sud Lípez, Bolivia', 'mineralogical', -22.199, -67.781,
   'Laguna hipersalina con islas de bórax. Interesa porque el rover Curiosity detectó boro en vetas del cráter Gale; el bórax permite formular preguntas, no demuestra que los minerales sean iguales. Respaldo: sugerido.',
   'img/analogs/laguna-colorada.jpg', 'https://en.wikipedia.org/wiki/Laguna_Colorada'),
  ('canapa', 'Lagunas Cañapa y Chiarkota, Bolivia', 'environmental', -21.505, -68.014,
   'Lagunas hipersalinas que todavía no tienen estudios microbiológicos. Son una oportunidad de investigación nueva sobre vida en salmueras. Respaldo: propuesto.',
   'img/analogs/canapa.jpg', 'https://es.wikipedia.org/wiki/Laguna_Ca%C3%B1apa'),
  ('lago-poopo', 'Lago Poopó, Oruro, Bolivia', 'environmental', -18.55, -67.083,
   'Lago de altura que casi desapareció en la última década. Permite observar en tiempo real cómo se seca un lago y qué depósitos deja. Respaldo: sugerido.',
   'img/analogs/lago-poopo.jpg', 'https://en.wikipedia.org/wiki/Lake_Poop%C3%B3'),

  -- ---------- Hidrotermalismo ----------
  ('sol-de-manana', 'Sol de Mañana, Sud Lípez, Bolivia', 'mineralogical', -22.426, -67.76,
   'Campo de fumarolas, ollas de barro y fuentes termales a unos 4.900 m. Sirve para estudiar la alteración hidrotermal ácida con poca presión y mucha radiación UV. Peligroso: la costra es delgada. Respaldo: sugerido.',
   'img/analogs/sol-de-manana.jpg', 'https://en.wikipedia.org/wiki/Sol_de_Ma%C3%B1ana'),

  ('laguna-blanca-termal', 'Fuente termal de Laguna Blanca, Sud Lípez, Bolivia', 'environmental', -22.8, -67.794,
   'Fuente termal de unos 36 °C a 4.328 m con comunidades microbianas, incluida en estudios de extremófilos andinos. Ayuda a entender qué vida podría sostener un sistema hidrotermal de altura. Ubicación aproximada (junto a la laguna). Respaldo: estudiado.',
   'img/analogs/laguna-blanca-termal.jpg', 'https://en.wikipedia.org/wiki/Laguna_Blanca_(Bolivia)'),

  -- ---------- Volcanes y deslizamientos ----------
  ('tata-sabaya', 'Volcán Tata Sabaya, Oruro, Bolivia', 'geomorphological', -19.133, -68.533,
   'Hace unos 12.000 años su flanco colapsó y formó una avalancha de escombros que dejó montículos, hoy "islas" en el salar de Coipasa. Es análogo de los colapsos de volcanes y de los grandes deslizamientos de Marte. Respaldo: sugerido.',
   'img/analogs/tata-sabaya.jpg', 'https://doi.org/10.5027/andgeoV39n3-a03'),
  ('ollague', 'Volcán Ollagüe, Bolivia–Chile', 'geomorphological', -21.283, -68.183,
   'Volcán con domos y coladas de lava muy bien conservado gracias a la aridez: casi no está erosionado, como los volcanes marcianos. Respaldo: sugerido.',
   'img/analogs/ollague.jpg', 'https://en.wikipedia.org/wiki/Ollag%C3%BCe'),
  ('intersalar', 'Cordillera Intersalar, Bolivia', 'geomorphological', -19.7, -67.9,
   'Domos de lava planos y extensos depósitos de flujos piroclásticos (ignimbritas) entre los salares de Uyuni y Coipasa. Análogo de depósitos volcánicos marcianos. Ubicación aproximada. Respaldo: sugerido.',
   null, null),
  ('sajama', 'Volcán Sajama, Bolivia', 'operational', -18.11, -68.88,
   'Terreno volcánico de altura, con pendientes y frío, para probar arranque de baterías, estabilidad y procedimientos de campo de rovers. Candidato por procesos: no todos sus materiales son basálticos y cada sector requiere comprobación.',
   null, 'https://en.wikipedia.org/wiki/Nevado_Sajama'),

  -- ---------- Hielo ----------
  ('sajama-hielo', 'Glaciar del Sajama, Bolivia', 'geomorphological', -18.11, -68.88,
   'De estos glaciares se extrajeron núcleos de hielo con miles de años de historia climática. Es un análogo conceptual de las capas de hielo y polvo de los polos de Marte, que también guardan el clima. Respaldo: sugerido.',
   null, 'https://doi.org/10.1126/science.282.5395.1858'),
  ('cordillera-real', 'Cordillera Real, Bolivia', 'environmental', -16.633, -67.791,
   'Sus glaciares retroceden rápido y dejan terreno nuevo expuesto: un laboratorio natural para estudiar la pérdida de hielo. Respaldo: sugerido.',
   'img/analogs/cordillera-real.jpg', 'https://en.wikipedia.org/wiki/Cordillera_Real_(Bolivia)'),
  ('glaciares-roca', 'Glaciares de roca de los Andes de Bolivia (incl. Caquella)', 'geomorphological', -21.5, -67.95,
   'Hielo cubierto por una capa de rocas en un ambiente seco, igual que los glaciares cubiertos de detritos de las latitudes medias de Marte. Hay 94 inventariados, 54 activos. Ubicación aproximada (Caquella, Lípez). Respaldo: estudiado.',
   null, 'https://doi.org/10.1002/ppp.1816'),
  ('permafrost-occidental', 'Permafrost de la Cordillera Occidental, Bolivia', 'environmental', -18.3, -68.9,
   'Por encima de unos 4.700 m hay suelo congelado y suelo "ordenado" por las heladas nocturnas, un proceso que se compara con el hielo del suelo marciano. Ubicación aproximada. Respaldo: sugerido.',
   null, null),

  -- ---------- Viento ----------
  ('siloli', 'Desierto de Siloli y Árbol de Piedra, Bolivia', 'geomorphological', -22.037, -67.882,
   'Desierto frío a más de 4.500 m con rocas esculpidas por el viento; el Árbol de Piedra es un ventifacto de unos 7 m. Sirve para comparar la erosión eólica de Marte. Respaldo: propuesto.',
   'img/analogs/siloli.jpg', 'https://es.wikipedia.org/wiki/Desierto_Siloli'),
  ('italia-perdida', 'Italia Perdida y Bosque de Piedras, Bolivia', 'geomorphological', -21.719, -67.528,
   'Rocas volcánicas esculpidas por la erosión, comparables con las rocas pulidas por el viento que fotografían los rovers. Respaldo: sugerido.',
   'img/analogs/italia-perdida.jpg', 'https://es.wikipedia.org/wiki/Italia_Perdida'),
  ('tajzara', 'Dunas de Tajzara, Tarija, Bolivia', 'geomorphological', -21.717, -65.071,
   'Dunas a gran altitud, útiles para estudiar el movimiento de arena en un ambiente frío y seco. Todavía sin estudios microbiológicos. Respaldo: propuesto.',
   'img/analogs/tajzara.jpg', 'https://en.wikipedia.org/wiki/Tajzara_Lake'),
  ('desierto-dali', 'Desierto de Dalí, Sud Lípez, Bolivia', 'environmental', -22.615, -67.664,
   'Desierto frío y árido de altura todavía sin estudios microbiológicos; señalado como oportunidad para estudiar vida en condiciones extremas. Respaldo: propuesto.',
   'img/analogs/desierto-dali.jpg', 'https://en.wikipedia.org/wiki/Salvador_Dal%C3%AD_Desert'),

  -- ---------- Cráteres, corteza antigua y operaciones ----------
  ('iturralde', 'Estructura de Iturralde (Araona), La Paz, Bolivia', 'geomorphological', -12.587, -67.675,
   'Estructura circular de unos 8 km y solo 20 m de profundidad en la llanura amazónica. Se compara con los cráteres degradados ("fantasma") de las llanuras del norte de Marte. Su origen por impacto todavía no está confirmado. Respaldo: propuesto.',
   'img/analogs/iturralde.jpg', 'https://svs.gsfc.nasa.gov/925'),
  ('guapore', 'Escudo de Guaporé (cratón amazónico), Bolivia', 'mineralogical', -15.5, -61.5,
   'Corteza muy antigua (precámbrica) que podría servir para estudiar cómo se meteoriza una corteza vieja. No tiene relieve de cráteres como Marte. Ubicación aproximada. Respaldo: sugerido.',
   'img/analogs/guapore.jpg', 'https://en.wikipedia.org/wiki/Amazonian_Craton'),
  ('cerro-rico', 'Cerro Rico de Potosí, Bolivia', 'mineralogical', -19.619, -65.75,
   'Drenaje ácido de mina con química rica en hierro y sulfatos, parecida a la de Río Tinto y Meridiani Planum. Su origen es humano (casi 500 años de minería). Respaldo: sugerido.',
   'img/analogs/cerro-rico.jpg', 'https://en.wikipedia.org/wiki/Cerro_Rico'),
  ('torotoro', 'Parque Nacional Torotoro, Bolivia', 'operational', -18.13, -65.76,
   'Cañón de 250–300 m con capas sedimentarias expuestas para entrenar lectura de estratos e interpretación de imágenes, como hacen los rovers. Analogía de método: su origen es fluvial, no tectónico como Valles Marineris. Respaldo: sugerido.',
   'img/analogs/torotoro.jpg', 'https://en.wikipedia.org/wiki/Torotoro_National_Park'),
  ('umajalanta', 'Caverna de Umajalanta, Torotoro, Bolivia', 'operational', -18.114, -65.812,
   'La cueva más larga de Bolivia (unos 4,6 km). Sirve para practicar navegación, comunicaciones y mapeo bajo tierra. Es una cueva de caliza, no un tubo de lava: el análogo es operacional, no geológico. Respaldo: sugerido.',
   'img/analogs/umajalanta.jpg', 'https://es.wikipedia.org/wiki/Caverna_de_Umajalanta'),
  ('valle-de-la-luna', 'Valle de la Luna, Mallasa, La Paz, Bolivia', 'operational', -16.567, -68.094,
   'Cárcavas, pináculos y sombras para practicar fotogrametría, mapeo 3D y navegación de rovers. Se recomienda usar modelos digitales: las formaciones son frágiles. Un relieve parecido no implica el mismo origen. Respaldo: candidato metodológico (F2).',
   null, 'https://en.wikipedia.org/wiki/Valle_de_la_Luna_(Bolivia)'),
  ('sud-lipez', 'Reserva Eduardo Avaroa, Sud Lípez, Bolivia', 'operational', -22.4, -67.6,
   'Mosaico de arena, grava, rocas volcánicas y lagunas para probar suspensión, patinaje y navegación de rovers sin GPS. Es un área protegida: requiere permisos y no se entra a fumarolas ni lagunas sensibles. Ubicación aproximada. Respaldo: propuesta del informe F2.',
   null, 'https://en.wikipedia.org/wiki/Eduardo_Avaroa_Andean_Fauna_National_Reserve'),

  -- =====================================================================
  -- LATINOAMÉRICA (fuera de Bolivia)
  -- =====================================================================
  ('el-tatio', 'Géiseres de El Tatio, Chile', 'mineralogical', -22.33, -68.01,
   'Campo hidrotermal de altura con depósitos de sílice, comparable con los depósitos hidrotermales de Home Plate y relevante para la preservación de biofirmas.',
   'img/analogs/el-tatio.jpg', 'https://en.wikipedia.org/wiki/El_Tatio'),
  ('atacama', 'Desierto de Atacama, Chile', 'environmental', -24.5, -69.25,
   'Uno de los lugares más áridos de la Tierra, con sales y alta radiación UV. Se usa para estudiar los límites de la vida en condiciones de extrema sequedad.',
   'img/analogs/atacama.jpg', 'https://en.wikipedia.org/wiki/Atacama_Desert'),

  -- =====================================================================
  -- RESTO DEL MUNDO
  -- =====================================================================
  ('rio-tinto', 'Río Tinto, España', 'mineralogical', 37.69, -6.59,
   'Aguas ácidas ricas en hierro con sulfatos de hierro, comparables con los sulfatos y la alteración química de Meridiani Planum.',
   'img/analogs/rio-tinto.jpg', 'https://en.wikipedia.org/wiki/Rio_Tinto_(river)'),
  ('salda', 'Lago Salda, Turquía', 'mineralogical', 37.55, 29.68,
   'Lago con carbonatos y sedimentos que se compara con el antiguo lago y delta del cráter Jezero.',
   'img/analogs/salda.jpg', 'https://en.wikipedia.org/wiki/Lake_Salda'),
  ('kilauea', 'Kīlauea, Hawái, EE.UU.', 'mineralogical', 19.41, -155.28,
   'Volcán en escudo de basalto. Sus coladas sirven para comparar los basaltos de los mares lunares y los volcanes de Tharsis.',
   null, 'https://en.wikipedia.org/wiki/K%C4%ABlauea'),
  ('grand-canyon', 'Gran Cañón, EE.UU.', 'geomorphological', 36.1, -112.1,
   'Cañón con paredes estratificadas expuestas. Se parece en forma y capas a Valles Marineris, aunque a una escala mucho menor y con otro origen (erosión fluvial, no tectónica).',
   'img/analogs/grand-canyon.jpg', 'https://en.wikipedia.org/wiki/Grand_Canyon'),
  ('meteor-crater', 'Meteor Crater, Arizona, EE.UU.', 'geomorphological', 35.03, -111.02,
   'Cráter de impacto simple y bien conservado, con borde elevado y eyecta. Referencia clásica para comparar cráteres lunares y marcianos.',
   'img/analogs/meteor-crater.jpg', 'https://en.wikipedia.org/wiki/Meteor_Crater'),
  ('haughton', 'Cráter Haughton, isla Devon, Canadá', 'geomorphological', 75.38, -89.68,
   'Cráter de impacto en un ambiente polar, frío y seco, útil para estudiar eyecta, erosión e hidrotermalismo de impacto.',
   'img/analogs/haughton.jpg', 'https://en.wikipedia.org/wiki/Haughton_impact_crater'),
  ('haughton-hmp', 'Haughton-Mars Project, isla Devon, Canadá', 'operational', 75.43, -89.82,
   'Campamento de investigación donde se ensayan exploración humana y robótica, vehículos y procedimientos de campo en condiciones polares.',
   'img/analogs/haughton-hmp.jpg', 'https://en.wikipedia.org/wiki/Haughton%E2%80%93Mars_Project'),
  ('mdrs', 'Mars Desert Research Station, Utah, EE.UU.', 'operational', 38.41, -110.79,
   'Estación de simulación de misiones tripuladas a Marte en un terreno sedimentario árido cerca de Hanksville.',
   'img/analogs/mdrs.jpg', 'https://mdrs.marssociety.org/'),
  ('hi-seas', 'HI-SEAS, Mauna Loa, Hawái, EE.UU.', 'operational', 19.6, -155.48,
   'Hábitat de simulación sobre terreno volcánico para estudiar aislamiento, operaciones y trabajo de tripulaciones.',
   null, 'https://en.wikipedia.org/wiki/HI-SEAS'),
  ('basalt', 'NASA BASALT, Craters of the Moon, Idaho, EE.UU.', 'operational', 43.42, -113.52,
   'Proyecto de NASA que combina exploración geológica en terreno basáltico con decisiones científicas y comunicaciones demoradas.',
   'img/analogs/basalt.jpg', 'https://www.nasa.gov/missions/analog-field-testing/what-is-basalt/'),
  ('lanzarote-pangaea', 'Lanzarote, España (ESA PANGAEA)', 'operational', 29.0, -13.6,
   'Entrenamiento geológico de astronautas de la ESA en terreno volcánico y tubos de lava.',
   'img/analogs/lanzarote-pangaea.jpg', 'https://www.esa.int/Science_Exploration/Human_and_Robotic_Exploration/CAVES_and_Pangaea/What_is_PANGAEA'),
  ('mcmurdo', 'Valles Secos de McMurdo, Antártida', 'environmental', -77.5, 162.0,
   'Desierto polar muy frío y seco con suelos congelados y polígonos. Se compara con el hielo subsuperficial de las llanuras marcianas y con el frío extremo de los polos.',
   'img/analogs/mcmurdo.jpg', 'https://en.wikipedia.org/wiki/McMurdo_Dry_Valleys'),
  ('concordia', 'Estación Concordia, Antártida', 'operational', -75.1, 123.33,
   'Base en la meseta antártica usada para estudiar aislamiento prolongado, frío y oscuridad, como en una misión de larga duración.',
   'img/analogs/concordia.jpg', 'https://en.wikipedia.org/wiki/Concordia_Station')
on conflict (id) do update set
  name = excluded.name, category = excluded.category, lat = excluded.lat, lon = excluded.lon,
  why = excluded.why, image = excluded.image, source = excluded.source;
