-- =====================================================================
-- 09 · ANÁLOGOS NUEVOS (COMPLETOS)                        Dueño: Miguel
-- =====================================================================
-- Prioridad: análogos para la LUNA, que hoy tiene muy pocos.
-- Cada análogo nuevo va completo en ESTE archivo, en este orden:
--   1. insert into public.analogs (...)          datos básicos, como en 02_analogs.sql
--   2. update secondary_categories / breaking_point, como en 05_analogias_quiebre.sql
--   3. insert into public.analog_aspects (...)   sus límites, con el formato de 06_limites.sql
--   4. insert into public.analog_trainings (...) sus entrenamientos, con el formato de 08
--   5. insert into public.zone_analogs (...)     con zonas existentes o las nuevas de Santiago (07)
--
-- Usa siempre "on conflict ... do update" (o "do nothing" en zone_analogs) para que el
-- archivo se pueda correr varias veces. Verifica coordenadas y enlaces antes de agregarlos.
--
-- Reglas de contenido (README y CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md, sección 12):
--   * Nada sin fuente real. Si no hay fuente, deja source en null y dilo en el texto.
--   * Lenguaje sencillo: lo lee un estudiante, no un especialista.
--   * Comillas simples dentro del texto se escriben dobles: 'no ''simula'' Marte'.
-- Después de editar: bash supabase/seed/exportar-json.sh  (regenera src/data/*.json)
--
-- Ejemplo de inicio (formato):
--
-- insert into public.analogs (id, name, category, lat, lon, why, image, source) values
--   ('nuevo-id', 'Nombre, País', 'operational', 0.0, 0.0, 'Por qué se parece...', null, 'https://...')
-- on conflict (id) do update set
--   name = excluded.name, category = excluded.category, lat = excluded.lat, lon = excluded.lon,
--   why = excluded.why, image = excluded.image, source = excluded.source;

-- Seis sitios con prioridad lunar. No dependen de ids aún no definidos en 07:
-- se relacionan con las cuatro zonas lunares existentes y, cuando corresponde, con Marte.
-- Las asociaciones indican una pregunta parcial (método, forma o material), no equivalencia total.
-- Las coordenadas son puntos de referencia aproximados, no rutas ni permisos de acceso.
-- Coordenadas y contexto: Cinder Lake, guía de autores enlazada por USGS;
-- SP Mountain, guía USGS OFR 2021-1072 y mapa topográfico SP Mountain;
-- Lava River Cave (Arizona), LPI Contribution 1618, mapa 3 (aparcamiento de entrada);
-- Ries, LPI TR 88-03 (48°53 N, 10°37 E);
-- Mistastin, atlas LPI (55°53 N, 63°18 W);
-- Mauna Kea, Klingelhöfer et al., Mars 2014, 1497 (Pu'u Hiwahine, no la cumbre).
-- Fuentes adicionales de ubicación:
-- https://www.lpi.usra.edu/lpi/contribution_docs/LPI-001618.pdf
-- https://pubs.usgs.gov/of/2021/1072/ofr20211072.pdf
-- https://www.lpi.usra.edu/lpi/contribution_docs/TR/TR_8803.pdf
-- https://www.lpi.usra.edu/publications/slidesets/craters/slide_25.html
-- Las actividades se proponen aquí; las fuentes acreditan el contexto o precedentes,
-- no la ejecución de este protocolo concreto. No se importan imágenes sin licencia verificada.

-- 1. Datos básicos, categorías secundarias y punto de quiebre.
insert into public.analogs
  (id, name, category, lat, lon, why, image, source, secondary_categories, breaking_point) values
  ('cinder-lake', 'Cinder Lake, campo de cráteres de entrenamiento, Arizona, EE.UU.',
   'operational', 35.306, -111.505,
   'Campo artificial construido para practicar exploración lunar. Permite ensayar localización, recorridos y observación de pequeños cráteres; su uso histórico está documentado por USGS.',
   null,
   'https://www.usgs.gov/data/cinder-lake-crater-field-uncrewed-aerial-system-derived-digital-elevation-models-2023-and-2024',
   array['geomorphological'],
   'Los cráteres se excavaron con explosivos en materiales volcánicos terrestres. No son impactos naturales ni reproducen vacío, gravedad lunar o regolito madurado por impactos; la erosión cambia sus formas.'),
  ('sp-mountain', 'SP Mountain y su colada, Arizona, EE.UU.',
   'geomorphological', 35.5822, -111.6319,
   'Cono volcánico y colada usados para estudiar procesos planetarios y practicar interpretación geológica. Complementa los mares lunares por formas volcánicas y los campos de prueba por recorridos.',
   null,
   'https://www.usgs.gov/news/virtual-field-trip-guide-s-p-mountain-just-released-astrogeology-science-center',
   array['operational'],
   'El cono y la colada se formaron con aire y gravedad terrestres. No representan todo un mar lunar ni un volcán marciano gigante; cenizas, suelos y erosión pueden ocultar los contactos.'),
  ('lava-river-cave-az', 'Lava River Cave, Coconino, Arizona, EE.UU.',
   'operational', 35.3422, -111.8353,
   'Tubo de lava para plantear estudios de navegación y cartografía subterránea. A diferencia de una cueva caliza, comparte el proceso volcánico general con las cavidades que se investigan en la Luna.',
   null,
   'https://www.usgs.gov/science/science-explorer/planetary-science/terrestrial-analogs',
   array['geomorphological'],
   'Es una cavidad terrestre con aire, humedad y acceso regulado. Sus dimensiones y estabilidad no prueban las de Marius Hills. La oscuridad no reproduce el frío de una sombra polar lunar.'),
  ('ries-crater', 'Cráter Nördlinger Ries, Alemania',
   'geomorphological', 48.8833, 10.6167,
   'Estructura de impacto usada en formación geológica de astronautas, incluido PANGAEA. Permite reconocer materiales fragmentados y fundidos por impacto y relacionarlos con su posición en el terreno.',
   null,
   'https://www.esa.int/Science_Exploration/Human_and_Robotic_Exploration/Exploration/Planetary_geology_with_Pangaea',
   array['mineralogical', 'operational'],
   'La erosión, el relleno posterior y la actividad humana modifican el cráter. Sus rocas objetivo y su escala difieren de Tycho; no reproduce eyecta lunar intacta ni condiciones de vacío.'),
  ('mistastin', 'Kamestastin / Mistastin, Labrador, Canadá',
   'geomorphological', 55.8833, -63.3,
   'Cráter de impacto complejo con parte de sus rocas objetivo de anortosita, útil para estudiar impactos y formar astronautas en geología de interés lunar; el precedente está documentado por la agencia canadiense.',
   null,
   'https://www.asc-csa.gc.ca/eng/multimedia/search/video/19470?type=2',
   array['mineralogical', 'operational'],
   'El lago, la erosión y la vegetación cambian la exposición de rocas. La anortosita comparte una familia de roca con la corteza lunar, pero no toda su composición, historia ni maduración superficial.'),
  ('mauna-kea-isru', 'Pu''u Hiwahine, Mauna Kea — ensayos ISRU, Hawái, EE.UU.',
   'operational', 19.7609, -155.4707,
   'Campo volcánico donde se documentaron ensayos de instrumentos, perforación y aprovechamiento de recursos locales (ISRU). El punto corresponde al sector de ensayos de 2010, no a la cumbre.',
   null,
   'https://www.hou.usra.edu/meetings/8thmars2014/pdf/1497.pdf',
   array['mineralogical'],
   'Los materiales volcánicos contienen agua y alteración terrestres. Perforar o extraer compuestos aquí no demuestra disponibilidad de hielo en Shackleton ni funcionamiento de una planta en vacío y gravedad lunar.')
on conflict (id) do update set
  name = excluded.name, category = excluded.category, lat = excluded.lat, lon = excluded.lon,
  why = excluded.why, image = excluded.image, source = excluded.source,
  secondary_categories = excluded.secondary_categories, breaking_point = excluded.breaking_point;

-- 2. Límites: una fila por cada categoría principal y secundaria.
insert into public.analog_aspects (analog_id, category, covers, breaks, source) values
  ('cinder-lake', 'operational',
   'El campo y sus modelos de elevación permiten practicar localización, planificación de recorridos y reconocimiento de cráteres.',
   'El entrenamiento es terrestre; la movilidad y los tiempos no se trasladan directamente a gravedad lunar. Los precedentes históricos no validan cualquier ejercicio nuevo.',
   'https://www.usgs.gov/data/cinder-lake-crater-field-uncrewed-aerial-system-derived-digital-elevation-models-2023-and-2024'),
  ('cinder-lake', 'geomorphological',
   'Las depresiones artificiales ofrecen bordes, sombras y superposiciones para interpretar la forma de pequeños cráteres.',
   'Se hicieron con explosivos: no reproducen el choque, los minerales ni la distribución de eyecta de un impacto a alta velocidad. El agua y el viento modifican el campo.',
   'https://www.usgs.gov/science/science-explorer/planetary-science/terrestrial-analogs'),
  ('sp-mountain', 'geomorphological',
   'El cono y la colada permiten reconocer un centro de emisión y relacionarlo con superficies y contactos volcánicos.',
   'Un cono de escorias terrestre no es igual a un domo lunar ni al escudo de Olympus Mons. Cambian gravedad, escala y preservación.',
   'https://www.usgs.gov/news/virtual-field-trip-guide-s-p-mountain-just-released-astrogeology-science-center'),
  ('sp-mountain', 'operational',
   'La guía de campo permite practicar observación, cartografía y decisiones de recorrido en un paisaje volcánico.',
   'Interpretar afloramientos con aire y gravedad terrestres no valida equipos para el vacío. El acceso y los recorridos necesitan autorización del responsable del terreno.',
   'https://www.usgs.gov/news/virtual-field-trip-guide-s-p-mountain-just-released-astrogeology-science-center'),
  ('lava-river-cave-az', 'operational',
   'La cavidad permite plantear navegación con iluminación propia, cartografía y estudio de enlaces con línea de visión limitada.',
   'Son ejercicios posibles sujetos a permiso; no se afirma que todos se hayan realizado. Hay aire y gravedad terrestres; la falta de luz no equivale a vacío o frío lunar.',
   'https://www.usgs.gov/science/science-explorer/planetary-science/terrestrial-analogs'),
  ('lava-river-cave-az', 'geomorphological',
   'El conducto se originó por circulación de lava bajo una cubierta solidificada, útil para reconocer formas de un tubo volcánico.',
   'Su tamaño y conservación terrestres no determinan los de una cavidad lunar; la existencia de este tubo no confirma una red accesible bajo Marius Hills.',
   'https://www.fs.usda.gov/r03/coconino/recreation/lava-river-cave'),
  ('ries-crater', 'geomorphological',
   'La estructura y depósitos de impacto permiten relacionar materiales excavados, deformación y ubicación dentro y fuera del cráter.',
   'El relieve está erosionado y parcialmente rellenado. La escala y las rocas objetivo no equivalen a las de Tycho ni permiten inferir sus procesos solo por parecido.',
   'https://www.lpi.usra.edu/lpi/contribution_docs/TR/TR_8803.pdf'),
  ('ries-crater', 'mineralogical',
   'Las rocas fragmentadas con material fundido permiten reconocer productos de un impacto y distinguirlos de rocas sin esa transformación.',
   'Los minerales dependen de las rocas objetivo terrestres. La presencia de fundido no implica la misma composición que los depósitos lunares.',
   'https://www.lpi.usra.edu/lpi/contribution_docs/TR/TR_8803.pdf'),
  ('ries-crater', 'operational',
   'PANGAEA usa el cráter para formación geológica: lectura del terreno, selección de observaciones y relación entre muestras y contexto.',
   'La práctica ocurre con afloramientos y accesos terrestres. No reproduce desplazamiento con traje presurizado ni riesgos de una misión lunar completa.',
   'https://www.esa.int/Science_Exploration/Human_and_Robotic_Exploration/Exploration/Planetary_geology_with_Pangaea'),
  ('mistastin', 'geomorphological',
   'La estructura de impacto complejo permite estudiar relaciones entre materiales y formas producidos por un gran impacto.',
   'Lago, vegetación y erosión ocultan o modifican rasgos. No conserva el relieve ni el sistema de rayos de un cráter lunar joven.',
   'https://www.asc-csa.gc.ca/eng/multimedia/search/video/19470?type=2'),
  ('mistastin', 'mineralogical',
   'Parte de las rocas objetivo son anortositas, una familia relevante para estudiar la corteza clara de la Luna y su transformación por impactos.',
   'Compartir esa familia de roca no iguala química, edad ni efectos acumulados de impactos. Las muestras terrestres no sustituyen análisis de material lunar.',
   'https://www.asc-csa.gc.ca/eng/multimedia/search/video/19470?type=2'),
  ('mistastin', 'operational',
   'La agencia canadiense documenta formación de astronautas en reconocimiento de geología de impacto en este entorno remoto.',
   'La logística remota no reproduce vacío ni gravedad lunar. Una campaña necesita coordinación local y apoyo real, además de los protocolos del ejercicio.',
   'https://www.asc-csa.gc.ca/eng/multimedia/search/video/19470?type=2'),
  ('mauna-kea-isru', 'operational',
   'Los ensayos documentados combinan instrumentos, perforación y análisis de recursos del subsuelo en un terreno volcánico.',
   'El rendimiento terrestre no certifica una planta lunar: cambian presión, gravedad, transferencia de calor y propiedades del suelo.',
   'https://www.nasa.gov/mission/in-situ-resource-utilization-isru/'),
  ('mauna-kea-isru', 'mineralogical',
   'Los materiales volcánicos permiten comparar respuestas de instrumentos que caracterizan minerales y compuestos aprovechables como recursos.',
   'Agua, alteración y materia orgánica terrestres pueden cambiar la señal. No se deducen concentraciones de hielo lunar ni composición de un mar lunar de estos materiales.',
   'https://www.hou.usra.edu/meetings/8thmars2014/pdf/1497.pdf')
on conflict (analog_id, category) do update set
  covers = excluded.covers, breaks = excluded.breaks, source = excluded.source;

-- 3. Entrenamientos posibles; las métricas son propuestas, no resultados publicados.
insert into public.analog_trainings
  (analog_id, position, audience, activity, measures, restrictions, source) values
  ('cinder-lake', 1, 'astronauts',
   'Propuesta: localizarse en el campo usando un mapa y las relaciones entre pequeños cráteres, después priorizar estaciones de observación.',
   'Error de posición, cráteres reconocidos, objetivos documentados y tiempo de decisión.',
   'No crear cráteres nuevos ni alterar los históricos. Actividad con responsables del terreno; mantener ayuda de seguridad disponible aunque el ejercicio limite el apoyo científico.',
   'https://www.usgs.gov/data/cinder-lake-crater-field-uncrewed-aerial-system-derived-digital-elevation-models-2023-and-2024'),
  ('cinder-lake', 2, 'rovers',
   'Propuesta: usar el modelo de elevación para evaluar rutas alrededor de bordes y comparar resultados con distintas iluminaciones simuladas.',
   'Colisiones simuladas, margen al borde, error de localización y rutas completadas.',
   'El modelo debe indicar resolución y fecha. Una ruta virtual segura no demuestra firmeza del suelo ni estabilidad real del vehículo.',
   'https://www.usgs.gov/data/cinder-lake-crater-field-uncrewed-aerial-system-derived-digital-elevation-models-2023-and-2024'),
  ('sp-mountain', 1, 'astronauts',
   'Propuesta: relacionar cono, colada y contactos visibles para reconstruir una secuencia de eventos y explicarla al equipo remoto.',
   'Contactos reconocidos, relaciones temporales correctas, calidad del croquis y claridad del informe.',
   'Usar la guía y puntos autorizados. No recoger muestras ni recorrer propiedad privada sin permiso; adaptar la ruta a estabilidad y accesibilidad.',
   'https://www.usgs.gov/news/virtual-field-trip-guide-s-p-mountain-just-released-astrogeology-science-center'),
  ('sp-mountain', 2, 'rovers',
   'Propuesta: contrastar un mapa de imágenes con una referencia revisada en campo y evaluar cómo cambian las rutas al reconocer contactos inciertos.',
   'Coincidencia de unidades, contactos omitidos, incertidumbre declarada e intervenciones de planificación.',
   'Preferir datos o réplicas; movilidad real solo en pista autorizada. No trasladar directamente la tracción terrestre a Luna o Marte.',
   'https://www.usgs.gov/publications/assessment-planetary-geologic-mapping-techniques-mars-using-terrestrial-analogs-sp'),
  ('lava-river-cave-az', 1, 'rovers',
   'Propuesta: reconstruir un tramo de cueva con cámara e iluminación propia, primero sobre un modelo o réplica.',
   'Error de mapa, cobertura, consumo de iluminación y recuperaciones tras perder referencias visuales.',
   'Campo solo con permiso y especialistas, respetando cierres y fauna. No dejar equipos ni marcas en la cueva; la simulación no demuestra estabilidad del techo.',
   'https://www.fs.usda.gov/r03/coconino/recreation/lava-river-cave'),
  ('lava-river-cave-az', 2, 'astronauts',
   'Propuesta: planear observación subterránea y retorno con un presupuesto de tiempo y contingencias ficticias de pérdida de iluminación o enlace.',
   'Tiempo de retorno, objetivos registrados y decisiones correctas ante avisos simulados.',
   'Simular fallos sobre el papel o en réplica, sin apagar luces ni enlaces de seguridad reales. No extrapolar a una EVA en una cavidad lunar sin atmósfera.',
   'https://www.usgs.gov/science/science-explorer/planetary-science/terrestrial-analogs'),
  ('ries-crater', 1, 'astronauts',
   'Propuesta: seleccionar observaciones que distingan material excavado, fragmentado y fundido, y comunicar su contexto al equipo científico.',
   'Aciertos frente a una referencia, muestras o imágenes documentadas y calidad de la justificación científica.',
   'El precedente PANGAEA no prueba este protocolo exacto. Observación o colecciones autorizadas; sin entrar a canteras ni retirar material sin permiso.',
   'https://www.esa.int/Science_Exploration/Human_and_Robotic_Exploration/Exploration/Planetary_geology_with_Pangaea'),
  ('ries-crater', 2, 'science',
   'Propuesta: clasificar imágenes de rocas de impacto y contrastar las hipótesis con descripciones petrográficas de referencia.',
   'Precisión por clase, falsos positivos y casos que necesitan microscopía o análisis adicional.',
   'Usar colecciones con procedencia conocida. La textura visual no basta para identificar un mineral ni para inferir composición de Tycho.',
   'https://www.lpi.usra.edu/lpi/contribution_docs/TR/TR_8803.pdf'),
  ('mistastin', 1, 'astronauts',
   'Propuesta: planear una travesía para reconocer rocas objetivo y materiales de impacto, priorizando contexto antes que cantidad de muestras.',
   'Estaciones justificadas, relaciones entre rocas correctamente descritas y calidad de registros de ubicación.',
   'Coordinar permisos con autoridades y comunidades locales, apoyo remoto y evacuación real. No se afirma ejecución de esta variante; usar datos de archivo si no hay acceso autorizado.',
   'https://www.asc-csa.gc.ca/eng/multimedia/search/video/19470?type=2'),
  ('mistastin', 2, 'science',
   'Propuesta: comparar anortositas y rocas de impacto mediante imágenes y análisis de referencia, declarando límites de la identificación visual.',
   'Clases identificadas, diferencias con la referencia y proporción de conclusiones que necesitan análisis adicional.',
   'Trabajar con datos o muestras autorizadas. No igualar toda anortosita terrestre con la composición lunar ni extraer rocas sin permiso.',
   'https://www.asc-csa.gc.ca/eng/multimedia/search/video/19470?type=2'),
  ('mauna-kea-isru', 1, 'rovers',
   'Propuesta: coordinar reconocimiento de terreno, selección de un punto de análisis y entrega de datos para una operación de recursos locales.',
   'Objetivos completados, error de ubicación, intervenciones y consumo por tarea.',
   'Usar un sector expresamente autorizado y respetar patrimonio cultural y ambiental. Los precedentes no implican acceso actual; el ensayo no demuestra presencia de hielo lunar.',
   'https://www.nasa.gov/mission/in-situ-resource-utilization-isru/'),
  ('mauna-kea-isru', 2, 'science',
   'Propuesta: comparar resultados de instrumentos sobre materiales volcánicos de referencia para decidir qué análisis reduce la incertidumbre sobre recursos.',
   'Repetibilidad, diferencias entre instrumentos, contaminación de blancos y error respecto de composición conocida.',
   'Priorizar colecciones o simulantes; perforación y extracción solo con autorización. La humedad terrestre no debe confundirse con volátiles disponibles en Shackleton.',
   'https://www.hou.usra.edu/meetings/8thmars2014/pdf/1497.pdf')
on conflict (analog_id, position) do update set
  audience = excluded.audience, activity = excluded.activity, measures = excluded.measures,
  restrictions = excluded.restrictions, source = excluded.source;

-- 4. Zonas existentes: sin dependencia de ids nuevos de Santiago.
-- Tranquillitatis: práctica sobre pequeños cráteres y reconocimiento de terrenos volcánicos.
-- Tycho: geología de impactos; Ries y Mistastin no se presentan como réplicas del cráter.
-- Marius Hills: formas volcánicas y navegación en tubo de lava.
-- Shackleton: SOLO método de prospección de recursos; Mauna Kea no reproduce sombra polar.
insert into public.zone_analogs (zone_id, analog_id) values
  ('moon-tranquillitatis', 'cinder-lake'),
  ('moon-tycho', 'cinder-lake'),
  ('moon-tranquillitatis', 'sp-mountain'),
  ('moon-marius-hills', 'sp-mountain'),
  ('mars-olympus-mons', 'sp-mountain'),
  ('moon-marius-hills', 'lava-river-cave-az'),
  ('moon-tycho', 'ries-crater'),
  ('moon-tycho', 'mistastin'),
  ('moon-shackleton', 'mauna-kea-isru'),
  ('moon-tranquillitatis', 'mauna-kea-isru')
on conflict do nothing;
