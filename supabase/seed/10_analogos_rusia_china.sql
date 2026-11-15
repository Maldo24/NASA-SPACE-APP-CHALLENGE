-- =====================================================================
-- 10 · ANÁLOGOS DE RUSIA Y CHINA (COMPLETOS)                 Dueño: Maldo
-- =====================================================================
-- Tres análogos marcianos nuevos con su ficha completa (datos, límites, entrenamientos y zonas),
-- en el formato de los documentos de origen:
-- por cada tipo de analogía, lo que SÍ coincide (covers = analogía correcta) y lo que NO
-- (breaks = analogía incorrecta), con datos cuantitativos. Donde la fuente dice "sin datos" o
-- "no aplica", el texto lo dice.
--
-- Documentos de origen (entregados al equipo, no están en el repo):
--   * "Análogos marcianos en Rusia" — Tolbachik (Kamchatka) y Yakutia Central (Siberia).
--   * "Análogo marciano: Cuenca de Qaidam" — playa de Dalangtan.
-- Fuentes verificadas que se enlazan:
--   * Qaidam: Xiao et al. (2017), Earth-Science Reviews, doi:10.1016/j.earscirev.2016.11.003
--   * Yakutia: Ulrich et al. (2010), JGR Planets, doi:10.1029/2010JE003640
--   * Tolbachik: solo Wikipedia (ubicación); falta un artículo científico específico.
--
-- Va en un archivo propio (y no en 09, que es de Miguel) para no pisarse. Es el último en
-- cargarse (número 10), así que puede relacionarse con zonas de 03 y con las nuevas de Santiago (07).

-- ---------------------------------------------------------------------
-- 1. Datos básicos, analogías en parte y punto de quiebre
-- ---------------------------------------------------------------------
insert into public.analogs (id, name, category, lat, lon, why, image, source, secondary_categories, breaking_point) values
  ('tolbachik', 'Volcán Tolbachik, Kamchatka, Rusia', 'geomorphological', 55.75, 160.29,
   'Complejo volcánico activo con conos de ceniza, campos de lava, tubos de lava y permafrost dentro de depósitos volcánicos. Sus conos se compararon con posibles conos volcánicos del norte de Marte y su escoria tiene una textura cercana a la del regolito marciano. Coordenadas de su estación de monitoreo de permafrost. Patrimonio de la UNESCO: requiere permisos.',
   null, 'https://en.wikipedia.org/wiki/Tolbachik',
   array['environmental', 'mineralogical'],
   'Es un volcán activo, con nieve de hasta 2 m y un permafrost que ronda los 0 °C a 1.100 m de altura. Los volcanes de Tharsis están apagados desde hace mucho y el suelo marciano está muy por debajo de 0 °C, con 0,38 veces la gravedad terrestre.'),

  ('yakutia', 'Yakutia Central, cuenca del río Lena, Rusia', 'geomorphological', 62.03, 129.73,
   'Permafrost muy rico en hielo, con termokarst, lagos de deshielo y cuñas de hielo. Sus depresiones en las riberas del Lena se comparan con las depresiones festoneadas que deja la sublimación del hielo del subsuelo en Utopia Planitia. Ubicación aproximada (Yakutsk).',
   null, 'https://doi.org/10.1029/2010JE003640',
   array['environmental'],
   'Sus depresiones se forman cuando el hielo se derrite y el agua escapa; en Utopia Planitia el hielo se sublima, pasando directo a gas. Además, en verano Yakutia llega a unos 38 °C y tiene ríos con suelo sin hielo debajo.'),

  ('qaidam', 'Playa de Dalangtan, cuenca de Qaidam, China', 'mineralogical', 38.33, 91.67,
   'Cuenca cerrada e hiperárida de la meseta tibetana, a unos 2.700 m. De sus 24 minerales de sal, 6 también se detectaron en Marte, y en su suelo hay percloratos. Se estudia como análogo de Marte desde 2008 y el Servicio Geológico de China la usa para probar equipos.',
   null, 'https://doi.org/10.1016/j.earscirev.2016.11.003',
   array['geomorphological', 'environmental', 'operational'],
   'La presión del aire es de unos 709 mbar, unas cien veces la de Marte, y la temperatura media anual es de 3,5 °C. Sus sales se formaron en lagos de hace pocos millones de años; las de Marte son mucho más antiguas.')
on conflict (id) do update set
  name = excluded.name, category = excluded.category, lat = excluded.lat, lon = excluded.lon,
  why = excluded.why, image = excluded.image, source = excluded.source,
  secondary_categories = excluded.secondary_categories, breaking_point = excluded.breaking_point;

-- ---------------------------------------------------------------------
-- 2. Analogías correctas (covers) e incorrectas (breaks), por tipo
-- ---------------------------------------------------------------------
insert into public.analog_aspects (analog_id, category, covers, breaks, source) values

  -- ------------------------------------------------ tolbachik (geo + amb, min)
  ('tolbachik', 'geomorphological',
   'La erupción de 1975–76 cubrió unos 500 km² con escoria y ceniza y formó tres conos nuevos y campos de lava; sus conos se compararon con 14 posibles conos volcánicos del norte de Marte. Tiene tubos de lava, el tipo de cueva más probable en Marte, y glaciares cubiertos de ceniza estudiados como análogo de los glaciares marcianos.',
   'Son conos y coladas recientes y pequeños frente a Tharsis, y la comparación es de forma: no confirma que esos conos de Marte sean volcánicos. Su cueva mayor, Shokoladnaya, mide 339 m; se cree que los tubos marcianos serían mucho mayores.',
   null),
  ('tolbachik', 'environmental',
   'Permafrost dentro de escoria y ceniza: capa congelada de 12 a 16 m, con temperatura media de 0 a −1 °C a 1.100 m y de unos −7 °C a 2.600 m. En ese permafrost volcánico se encontraron microbios viables y metano (unos 1.100–1.900 µl de CH₄ por kg de muestra).',
   'Es un permafrost tibio, cerca de 0 °C, con nieve de más de 2 m en zonas de bosque y aire denso; el suelo de Marte está muy bajo cero. Sin datos de luz ni de polvo: no tiene noche polar ni tormentas de polvo, solo caída de ceniza sobre la nieve.',
   null),
  ('tolbachik', 'mineralogical',
   'Escoria basáltica muy porosa, con textura cercana a la del regolito marciano y conductividad térmica muy baja: 0,17 W/m·K seca y 0,44 W/m·K con 45 % de humedad.',
   'Los tubos de la erupción de 2012–13 tienen formaciones minerales inusuales, pero sin datos cuantitativos. La escoria se parece en textura; su composición no se ha comparado con la del regolito de Marte en estas fuentes.',
   null),

  -- ------------------------------------------------ yakutia (geo + amb)
  ('yakutia', 'geomorphological',
   'Termokarst (hundimiento del suelo al perder hielo) en cerca de la mitad de Yakutia, con lagos, cuñas de hielo y depresiones en la ribera del Lena comparadas con las depresiones festoneadas de Utopia Planitia.',
   'En Yakutia las depresiones se forman por deshielo, con agua líquida; en Utopia, por sublimación: se parece la forma, no el proceso. Bajo sus ríos hay taliks, suelo sin hielo, algo que no se conoce en Utopia Planitia. Sin datos de minerales.',
   null),
  ('yakutia', 'environmental',
   'Uno de los lugares habitados más fríos de la Tierra: récord de −67,7 °C cerca de Oymyakon y permafrost continuo de −5 a −13 °C. El permafrost siberiano tiene unos 350 m de espesor medio (hasta 1.450 m) y hasta un 50 % de hielo entre los granos; el del noreste de Siberia lleva más de 3 millones de años congelado.',
   'En verano llega a unos 38 °C (más de 100 °C de diferencia en el año) y el suelo se descongela hasta 1,5–4 m de profundidad; Marte es frío todo el año, con una presión de cientos de pascales. Sin análogo documentado para el polvo.',
   null),

  -- ------------------------------------------------ qaidam (min + geo, amb, op)
  ('qaidam', 'mineralogical',
   'De 24 minerales de sal, 6 también están en Marte: yeso, starkeyita, kieserita, halita, silvita y bischofita. Hay sulfatos de magnesio en Dalangtan, cloruros en Qarhan, percloratos y cloratos en el suelo y arcillas como la clorita, también vista en Marte desde órbita.',
   'Comparte minerales, no su historia: son sales jóvenes de lagos terrestres que se rehidratan con la humedad de cada madrugada (más del 60 %). En Marte esos minerales llevan miles de millones de años en un aire casi sin agua.',
   null),
  ('qaidam', 'geomorphological',
   'Yardangs, dunas barján y costras de sal poligonales, todos con equivalentes en Marte; sus yardangs se comparan con los de Medusae Fossae. También tiene estructuras anulares de sal comparadas con estructuras del polo norte marciano.',
   'Sus yardangs están tallados en arenisca por vientos de hasta 20–22 m/s en aire denso; en Medusae Fossae el material es más blando y el aire mucho más tenue. Sin mediciones de tormentas de polvo.',
   null),
  ('qaidam', 'environmental',
   'Hiperárido: unos 50 mm de lluvia al año frente a 2.590 mm de evaporación (índice de aridez de unos 0,02), con heladas por debajo de −25 °C y UV alta por la altura. En sus sales viven halófilos y se recuperaron lípidos de bacterias y arqueas. Permite estudiar los límites usados para las «regiones especiales» de Marte: −25 °C o más y actividad del agua mayor que 0,5.',
   'La temperatura media es de 3,5 °C y en verano supera los 30 °C. La presión es de 709 mbar, el 70 % del nivel del mar, y la humedad de madrugada pasa del 60 %. Sin datos de permafrost ni cifras de radiación UV.',
   null),
  ('qaidam', 'operational',
   'El Servicio Geológico de China lo usa para probar espectroscopía y equipos. Es remoto pero de acceso relativamente fácil, con estación meteorológica propia desde 2012 y una serie de 32 años a menos de 50 km.',
   'Sirve para pruebas de ingeniería y de instrumentos; las fuentes no describen simulaciones con tripulación. No hay cuevas documentadas, y la gravedad y el aire son terrestres.',
   null)

on conflict (analog_id, category) do update set
  covers = excluded.covers, breaks = excluded.breaks, source = excluded.source;

-- ---------------------------------------------------------------------
-- 3. Zonas de Marte con las que se comparan
-- ---------------------------------------------------------------------
insert into public.zone_analogs (zone_id, analog_id) values
  ('mars-olympus-mons', 'tolbachik'),        -- conos, coladas y tubos de lava
  ('mars-deuteronilus-mensae', 'tolbachik'), -- glaciares cubiertos de ceniza
  ('mars-elysium-planitia', 'tolbachik'),    -- llanura volcánica cubierta de regolito (escoria con textura de regolito)
  ('mars-utopia-planitia', 'yakutia'),       -- termokarst y depresiones festoneadas (explícito en la fuente)
  ('mars-meridiani', 'qaidam'),              -- sulfatos y percloratos
  ('mars-icaria-planum', 'qaidam'),          -- cloruros
  ('mars-medusae-fossae', 'qaidam')          -- yardangs
on conflict do nothing;

-- ---------------------------------------------------------------------
-- 4. Entrenamientos posibles (formato de 08_entrenamientos.sql)
--    Solo lo que respaldan los documentos de origen. Son actividades posibles, no realizadas.
-- ---------------------------------------------------------------------
insert into public.analog_trainings (analog_id, position, audience, activity, measures, restrictions, source) values
  ('qaidam', 1, 'science',
   'Probar espectrómetros y otros instrumentos sobre sales que también existen en Marte (yeso, kieserita, halita), como hace el Servicio Geológico de China.',
   'Qué minerales identifica el instrumento, comparado con el análisis de laboratorio de las mismas muestras.',
   'Las sales se rehidratan con la humedad de la madrugada (más del 60 %): hay que registrar la hora y la humedad de cada medición.',
   null),
  ('qaidam', 2, 'rovers',
   'Pruebas de ingeniería de equipos y vehículos de futuras misiones en un sitio remoto pero de acceso relativamente fácil, sobre costras de sal, dunas y yardangs.',
   'Desempeño con vientos de hasta 20–22 m/s y oscilaciones diarias de 15–20 °C, comparado con la estación meteorológica del sitio.',
   'La gravedad y la presión (709 mbar) son terrestres; no hay mediciones de tormentas de polvo.',
   null),
  ('qaidam', 3, 'science',
   'Estudiar en el sitio los límites de las «regiones especiales» de Marte (−25 °C o más y actividad del agua mayor que 0,5) y la vida que resiste dentro de las sales.',
   'Temperatura, humedad y actividad del agua en las sales; presencia de halófilos y de lípidos de bacterias y arqueas.',
   null,
   null),

  ('tolbachik', 1, 'science',
   'Monitorear permafrost dentro de depósitos volcánicos con sondeos y registradores de temperatura, como en su estación a 1.330 m.',
   'Temperatura del suelo a distintas profundidades y altitudes (registradores entre 800 y 3.075 m) y espesor de la capa activa.',
   'Patrimonio de la UNESCO y área protegida: el acceso requiere permisos.',
   null),
  ('tolbachik', 2, 'science',
   'Practicar el mapeo 3D de tubos de lava y cuevas volcánicas, como el modelo topográfico del tubo Luch-2.',
   'Precisión del modelo 3D y del recorrido; como referencia, la cueva Shokoladnaya mide 339 m de largo y 25 m de profundidad.',
   'Volcán activo y área protegida: acceso con permisos.',
   null),
  ('tolbachik', 3, 'science',
   'Medir las propiedades térmicas de la escoria, que tiene una textura parecida a la del regolito marciano.',
   'Conductividad térmica según la humedad: 0,17 W/m·K en seco y 0,44 W/m·K con 45 % de humedad.',
   null,
   null),

  ('yakutia', 1, 'science',
   'Comparar el termokarst y las depresiones de la ribera del Lena con imágenes de las depresiones festoneadas de Utopia Planitia.',
   'Forma, tamaño y orientación de las depresiones y contenido de hielo del suelo.',
   'Se forman por deshielo, no por sublimación: se compara la forma, no el proceso.',
   null),
  ('yakutia', 2, 'science',
   'Estudiar cómo responde un permafrost muy rico en hielo a los cambios de temperatura.',
   'Temperatura del permafrost (−5 a −13 °C), espesor de la capa activa (1,5–4 m) y tendencia de calentamiento del aire (0,03 °C por año).',
   null,
   null)
on conflict (analog_id, position) do update set
  audience = excluded.audience, activity = excluded.activity, measures = excluded.measures,
  restrictions = excluded.restrictions, source = excluded.source;
