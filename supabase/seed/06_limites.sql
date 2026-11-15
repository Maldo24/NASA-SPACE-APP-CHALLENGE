-- =====================================================================
-- 06 · LÍMITES POR TIPO DE ANALOGÍA                         Dueño: Maldo
-- =====================================================================
-- Qué reproduce cada análogo y dónde se rompe, por cada tipo de analogía que cumple.
-- Tabla: analog_aspects (supabase/migrations/20261116000000_profundizacion.sql)
--
--   analog_id  id del análogo (ver checklist abajo)
--   category   geomorphological | mineralogical | environmental | operational
--   covers     qué reproduce el sitio en esa categoría
--   breaks     dónde deja de servir la analogía en esa categoría
--   source     enlace específico de ese límite, o null si vale la fuente del análogo
--
-- Una fila por cada categoría que el análogo cumple: la principal y las de "en parte".
-- Las categorías sin fila se muestran en la app como "No cubre".
-- environmental = condiciones para la vida (frío, aridez, UV, salinidad, presión, radiación).
-- operational   = qué se puede practicar ahí (astronautas, rovers, trajes, hábitats).
--
-- Reglas de contenido (README y CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md, sección 12):
--   * Nada sin fuente real. Si no hay fuente, deja source en null y dilo en el texto.
--   * Lenguaje sencillo: lo lee un estudiante, no un especialista.
--   * Comillas simples dentro del texto se escriben dobles: 'no ''simula'' Marte'.
-- Después de editar: bash supabase/seed/exportar-json.sh  (regenera src/data/*.json)
--
-- Ejemplo (formato; los textos hay que comprobarlos antes de usarlos):
--
-- insert into public.analog_aspects (analog_id, category, covers, breaks, source) values
--   ('uyuni', 'mineralogical',
--    'Cloruros, yeso y salmueras formados por evaporación de antiguos lagos.',
--    'No tiene percloratos comprobados y la sal es reciente, no de hace miles de millones de años.',
--    null),
--   ('uyuni', 'environmental',
--    'Frío nocturno, radiación UV alta y salmueras donde vive poca vida.',
--    'La presión del aire es unas 100 veces la de Marte, hay oxígeno y el campo magnético frena los rayos cósmicos.',
--    null)
-- on conflict (analog_id, category) do update set
--   covers = excluded.covers, breaks = excluded.breaks, source = excluded.source;
--
-- Checklist (51 análogos existentes; los nuevos de Miguel van en 09):
--   [x] atacama                principal: amb | en parte: min
--   [x] basalt                 principal: op  | en parte: geo, min
--   [x] canapa                 principal: amb | en parte: -
--   [x] cerro-rico             principal: min | en parte: -
--   [x] coipasa                principal: min | en parte: op
--   [x] concordia              principal: op  | en parte: amb
--   [x] cordillera-real        principal: amb | en parte: geo
--   [x] desierto-dali          principal: amb | en parte: geo
--   [x] el-tatio               principal: min | en parte: amb
--   [x] glaciares-roca         principal: geo | en parte: amb
--   [x] grand-canyon           principal: geo | en parte: -
--   [x] guapore                principal: min | en parte: -
--   [x] haughton               principal: geo | en parte: amb
--   [x] haughton-hmp           principal: op  | en parte: amb
--   [x] hi-seas                principal: op  | en parte: -
--   [x] intersalar             principal: geo | en parte: -
--   [x] italia-perdida         principal: geo | en parte: -
--   [x] iturralde              principal: geo | en parte: -
--   [x] kilauea                principal: min | en parte: geo
--   [x] lago-poopo             principal: amb | en parte: min
--   [x] lago-tauca             principal: geo | en parte: min
--   [x] laguna-blanca-termal   principal: amb | en parte: min
--   [x] laguna-colorada        principal: min | en parte: amb
--   [x] laguna-verde           principal: min | en parte: amb
--   [x] lanzarote-pangaea      principal: op  | en parte: geo
--   [x] la-salsa               principal: min | en parte: amb
--   [x] licancabur             principal: amb | en parte: min
--   [x] mcmurdo                principal: amb | en parte: geo
--   [x] mdrs                   principal: op  | en parte: geo
--   [x] meteor-crater          principal: geo | en parte: op
--   [x] ollague                principal: geo | en parte: -
--   [x] pastos-grandes         principal: min | en parte: amb
--   [x] permafrost-occidental  principal: amb | en parte: geo
--   [x] rio-tinto              principal: min | en parte: amb
--   [x] sajama                 principal: op  | en parte: geo, amb
--   [x] sajama-hielo           principal: geo | en parte: amb
--   [x] salares-capas          principal: geo | en parte: min
--   [x] salda                  principal: min | en parte: geo
--   [x] siloli                 principal: geo | en parte: amb
--   [x] sol-de-manana          principal: min | en parte: amb
--   [x] sud-lipez              principal: op  | en parte: geo, amb
--   [x] tajzara                principal: geo | en parte: amb
--   [x] tata-sabaya            principal: geo | en parte: -
--   [x] torotoro               principal: op  | en parte: geo
--   [x] umajalanta             principal: op  | en parte: -
--   [x] uyuni                  principal: min | en parte: amb
--   [x] uyuni-icaria           principal: min | en parte: -
--   [x] uyuni-navegacion       principal: op  | en parte: -
--   [x] uyuni-poligonos        principal: geo | en parte: -
--   [x] uyuni-salmueras        principal: amb | en parte: min
--   [x] valle-de-la-luna       principal: op  | en parte: geo

-- Criterio de lectura de las fuentes:
-- F4 = tmp/lectura/F4.txt; F2 = tmp/lectura/F2.txt. Se conserva su nivel de respaldo.
-- source enlaza el estudio o la institución que sustenta la comparación cuando se dispone de él.
-- NULL no convierte la página general del análogo en prueba de una analogía:
-- donde falta una publicación específica se indica en el texto y se cita el informe local.
-- Las diferencias con Luna/Marte son límites de transferencia, no mediciones hechas en el sitio.
-- No se deduce mineralogía de una fotografía ni equivalencia ambiental de la altitud.

insert into public.analog_aspects (analog_id, category, covers, breaks, source) values
  -- Atacama
  ('atacama', 'environmental',
   'La sequedad extrema permite estudiar cómo persisten organismos y señales de vida con muy poca agua.',
   'Incluso aquí hay vida y aportes de humedad. El aire, la gravedad y la protección atmosférica terrestres no reproducen la superficie marciana.',
   'https://science.nasa.gov/solar-system/analog-explorer/'),
  ('atacama', 'mineralogical',
   'Los depósitos salinos permiten comparar la concentración de sales y la conservación de señales orgánicas en terrenos secos; F4 recoge esta comparación.',
   'La mezcla de sales varía entre sectores. No basta para atribuir a Marte los mismos minerales o la misma historia del agua. Falta una fuente específica para el sector de esta ficha.',
   null),
  -- BASALT
  ('basalt', 'operational',
   'BASALT ensaya exploración y selección de muestras con equipos de campo y apoyo científico remoto, introduciendo demoras de comunicación.',
   'La demora es artificial. El aire y la gravedad son terrestres; un resultado de coordinación no certifica un traje ni un rover para vuelo.',
   'https://www.nasa.gov/missions/analog-field-testing/what-is-basalt/'),
  ('basalt', 'geomorphological',
   'Las coladas y superficies volcánicas de Craters of the Moon permiten reconocer unidades del terreno y planear recorridos entre obstáculos.',
   'La forma y la rugosidad son comparaciones parciales: faltan la historia de impactos y las condiciones de formación del relieve lunar o marciano.',
   'https://www.nasa.gov/missions/analog-field-testing/what-is-basalt/'),
  ('basalt', 'mineralogical',
   'Los terrenos basálticos permiten distinguir rocas volcánicas y seleccionar muestras con distintos grados de alteración.',
   'Compartir el nombre basalto no implica igual composición. El agua y el aire terrestres alteran las rocas de otra manera que en la Luna o Marte.',
   'https://www.nasa.gov/missions/analog-field-testing/what-is-basalt/'),
  -- Bolivia: se mantienen las reservas de F4 y F2.
  ('canapa', 'environmental',
   'F4 propone las lagunas Cañapa y Chiarkota para investigar la habitabilidad de aguas salinas de altura. Respaldo: propuesto.',
   'F4 señala falta de estudios microbiológicos; no se afirma ausencia de vida ni de estudios posteriores. Falta una fuente específica verificada. El agua líquida y la presión terrestre difieren de Marte.',
   null),
  ('cerro-rico', 'mineralogical',
   'F4 sugiere comparar el hierro y los sulfatos del drenaje ácido minero con minerales de alteración marcianos. Respaldo: sugerido.',
   'La minería expone materiales y modifica la circulación del agua. Falta una fuente analítica específica para esta comparación; no se confirma jarosita u otro mineral en cada punto sin análisis.',
   null),
  ('coipasa', 'mineralogical',
   'Los depósitos salinos de una cuenca evaporítica permiten comparar concentración de sales y sedimentación lacustre. Respaldo en F4: estudiado.',
   'Las sales se forman bajo clima y presión terrestres. No se puede trasladar la composición de Coipasa a una zona marciana sin contrastar sus datos minerales.',
   'https://science.nasa.gov/earth/earth-observatory/bolivian-salt-flats-151813/'),
  ('coipasa', 'operational',
   'F2 propone reconocimiento geológico y pruebas de movilidad en sectores autorizados de la cuenca salina.',
   'Es una posibilidad, no una campaña acreditada. Falta una fuente específica de ensayos. Hay que verificar resistencia de la costra, zonas inundadas y permisos; la tracción sigue siendo terrestre.',
   null),
  ('concordia', 'operational',
   'La estación permite estudiar convivencia, autonomía y trabajo de equipos durante aislamiento prolongado y oscuridad invernal.',
   'La evacuación puede ser imposible durante el invierno, pero el hábitat conserva gravedad y aire terrestres. No reproduce el soporte vital ni todos los riesgos de una misión espacial.',
   'https://www.esa.int/Science_Exploration/Human_and_Robotic_Exploration/Concordia/Spaceship_Concordia'),
  ('concordia', 'environmental',
   'Combina frío polar, aire seco, oscuridad estacional y menor disponibilidad de oxígeno por la altura.',
   'La falta de oxígeno por altura es una condición terrestre. No equivale al vacío lunar ni a la atmósfera de CO2 y la radiación de Marte.',
   'https://www.esa.int/Science_Exploration/Human_and_Robotic_Exploration/Concordia/Spaceship_Concordia'),
  ('cordillera-real', 'environmental',
   'F4 sugiere estudiar el cambio de hábitats al retirarse los glaciares y quedar expuestas nuevas superficies frías de altura. Respaldo: sugerido.',
   'El deshielo aporta agua líquida bajo aire terrestre; no representa la estabilidad del hielo marciano. Falta una fuente específica que valide la comparación planetaria.',
   null),
  ('cordillera-real', 'geomorphological',
   'Los frentes glaciares y el terreno descubierto permiten comparar formas de erosión y depósitos ligados al hielo, según la sugerencia de F4.',
   'El retroceso combina procesos terrestres y agua de fusión. Las formas por sí solas no prueban igual origen que las de Marte. Falta una fuente específica de la comparación.',
   null),
  ('desierto-dali', 'environmental',
   'F4 propone el ambiente frío y seco de altura para investigar tolerancia a la desecación. Respaldo: propuesto.',
   'Falta una fuente microbiológica específica verificada; no se da por demostrada una comunidad concreta. La altura no reproduce presión, temperatura ni radiación ionizante marcianas.',
   null),
  ('desierto-dali', 'geomorphological',
   'El paisaje árido con materiales volcánicos permite plantear comparaciones de superficies expuestas y erosión, como propuesta de F4.',
   'La semejanza visual no demuestra que sean los mismos depósitos que Medusae Fossae. Falta una fuente específica que compare procesos y materiales de ambos sitios.',
   null),
  ('el-tatio', 'mineralogical',
   'La sílice depositada por aguas termales y sus texturas se han comparado con la sílice observada por Spirit cerca de Home Plate.',
   'Texturas parecidas no prueban vida en Marte: el estudio admite procesos no biológicos. El Tatio es activo y terrestre; el depósito marciano conserva una historia antigua.',
   'https://www.nature.com/articles/ncomms13554'),
  ('el-tatio', 'environmental',
   'Las fuentes calientes en un ambiente alto, frío y seco permiten estudiar comunidades microbianas y conservación de sus señales.',
   'Hay agua líquida y organismos actuales bajo presión terrestre. No se reproduce el ambiente marciano actual ni se demuestra que Home Plate haya estado habitado.',
   'https://www.nature.com/articles/ncomms13554'),
  ('glaciares-roca', 'geomorphological',
   'Los cuerpos de hielo y detritos inventariados permiten comparar lenguas y frentes de material rocoso con relieves glaciares marcianos. Respaldo en F4: estudiado.',
   'El inventario distingue formas activas y relictas: no todas contienen hielo. La forma no determina por sí sola cuánto hielo existe ni iguala la evolución de un glaciar marciano.',
   'https://doi.org/10.1002/ppp.1816'),
  ('glaciares-roca', 'environmental',
   'Los glaciares de roca activos permiten estudiar conservación de hielo bajo detritos en los Andes áridos.',
   'No todos los cuerpos inventariados contienen hielo. Las condiciones de presión, balance de agua y clima son terrestres; no equivalen a las de las latitudes medias marcianas.',
   'https://doi.org/10.1002/ppp.1816'),
  ('grand-canyon', 'geomorphological',
   'Las paredes y capas expuestas permiten comparar estratos, pendientes y erosión; el USGS documenta su uso para enseñar interpretación geológica.',
   'El río excavó el Gran Cañón; la apertura tectónica fue fundamental en Valles Marineris. Cambian origen y escala; se compara la lectura del relieve, no una génesis idéntica.',
   'https://www.usgs.gov/science/science-explorer/planetary-science/terrestrial-analogs'),
  ('guapore', 'mineralogical',
   'F4 sugiere investigar la alteración de rocas de corteza precámbrica como comparación de una corteza antigua. Respaldo: sugerido.',
   'La meteorización tropical incluye lluvia, suelos y organismos. No demuestra la misma mineralogía que Mawrth Vallis. Falta una fuente específica y caracterización del afloramiento elegido.',
   null),
  ('haughton', 'geomorphological',
   'El cráter Haughton permite estudiar formas de impacto y materiales excavados en un ambiente polar, como recoge Haughton-Mars Project.',
   'La erosión por hielo y agua modifica el relieve terrestre; no conserva el mismo registro que un cráter lunar ni reproduce su gravedad.',
   'https://www.marsinstitute.no/hmp'),
  ('haughton', 'environmental',
   'El frío y la aridez del entorno polar permiten estudiar superficies con poca disponibilidad de agua.',
   'Hay atmósfera, agua estacional y ecosistemas terrestres. No se reproducen el vacío lunar ni la radiación ionizante marciana.',
   'https://www.marsinstitute.no/hmp'),
  ('haughton-hmp', 'operational',
   'Haughton-Mars Project investiga exploración humana y robótica desde un campamento en terreno polar remoto.',
   'La gravedad y la atmósfera son terrestres. Las restricciones de comunicaciones deben definirse para cada ensayo; el campamento no reproduce una misión completa.',
   'https://www.marsinstitute.no/hmp'),
  ('haughton-hmp', 'environmental',
   'El entorno polar ofrece frío, aridez y estacionalidad para estudios ambientales de campo.',
   'El suelo y la vida son terrestres, con disponibilidad de agua variable. No equivale a la presión ni a la radiación espacial de Utopia Planitia.',
   'https://www.marsinstitute.no/hmp'),
  ('hi-seas', 'operational',
   'El hábitat permite estudiar convivencia, aislamiento y rutinas de una tripulación en terreno volcánico.',
   'El confinamiento es de simulación y el entorno tiene aire y gravedad terrestres. Las reglas y equipos varían según la campaña; no se validan sistemas para vuelo solo por este ensayo.',
   'https://www.hi-seas.org/about-hi-seas'),
  ('intersalar', 'geomorphological',
   'F4 sugiere comparar domos y depósitos de flujos piroclásticos entre Uyuni y Coipasa con terrenos volcánicos marcianos. Respaldo: sugerido.',
   'Las ignimbritas y domos andinos no equivalen a un escudo basáltico como Olympus Mons. Falta una fuente específica y la comprobación del depósito concreto; la ubicación es aproximada.',
   null),
  ('italia-perdida', 'geomorphological',
   'F4 sugiere comparar rocas volcánicas esculpidas por erosión con formas fotografiadas por rovers. Respaldo: sugerido.',
   'Viento, agua y heladas pueden producir formas parecidas por caminos distintos. Falta una fuente específica que separe sus aportes; no se atribuye todo el relieve al viento.',
   null),
  ('iturralde', 'geomorphological',
   'La estructura circular de bajo relieve permite comparar la apariencia de una depresión degradada o cubierta de sedimentos. Respaldo en F4: propuesto.',
   'Su origen por impacto no está confirmado. La imagen de NASA no lo resuelve; la selva y los sedimentos dificultan el análisis. No debe presentarse como cráter de impacto demostrado.',
   'https://svs.gsfc.nasa.gov/925/'),
  ('kilauea', 'mineralogical',
   'Las lavas basálticas documentadas por USGS ofrecen una referencia terrestre para comparar rocas volcánicas lunares y marcianas.',
   'Basalto no significa composición idéntica: deben compararse minerales y química. El agua y el aire terrestres producen una alteración distinta a la de la Luna.',
   'https://www.usgs.gov/publications/geology-kilauea-volcano'),
  ('kilauea', 'geomorphological',
   'Las coladas y la construcción de un volcán en escudo permiten plantear comparaciones de formas volcánicas.',
   'Las escalas, la gravedad y las condiciones de erupción difieren. Un escudo terrestre no reproduce el tamaño de Olympus Mons ni toda su historia.',
   'https://www.usgs.gov/volcanoes/kilauea/science/geology-and-history'),
  ('lago-poopo', 'environmental',
   'F4 sugiere seguir cambios de agua y salinidad de un lago somero para estudiar efectos de la desecación sobre hábitats. Respaldo: sugerido.',
   'El balance de agua responde al clima y uso humano actuales; no reproduce el cambio planetario antiguo de Marte. Falta una fuente específica de la comparación y una serie local para cada fecha.',
   null),
  ('lago-poopo', 'mineralogical',
   'F4 sugiere estudiar los sedimentos y las sales que quedan expuestos cuando disminuye el agua.',
   'No se identifica una sal por el color de la superficie ni se iguala su composición a Jezero sin análisis. Falta una fuente mineralógica específica que valide esa comparación.',
   null),
  ('lago-tauca', 'geomorphological',
   'F4 sugiere usar antiguas orillas y terrazas de Tauca y Minchin para interpretar cambios de nivel de lagos. Respaldo: sugerido.',
   'Un registro lacustre no reproduce el colapso del subsuelo de Aureum Chaos. Cambian edad y procesos. Falta una fuente específica que valide esta comparación planetaria.',
   null),
  ('lago-tauca', 'mineralogical',
   'F4 sugiere comparar la sucesión de sedimentos de lago y sales de evaporación como registro de cambios del agua.',
   'No todas las capas tienen igual composición ni corresponden al mismo paleolago. Falta una fuente analítica específica para vincularlas a minerales de una zona marciana.',
   null),
  ('laguna-blanca-termal', 'environmental',
   'F4 recoge una fuente termal cercana a Laguna Blanca con comunidades microbianas: permite preguntar por vida en aguas calientes de altura. Respaldo: estudiado.',
   'La ubicación es aproximada y falta una fuente específica verificada de esa fuente termal. No se extienden sus condiciones a toda la laguna; la presión y el aporte de agua son terrestres.',
   null),
  ('laguna-blanca-termal', 'mineralogical',
   'F4 plantea el interés de los depósitos de un entorno termal para investigar la relación entre minerales y señales microbianas.',
   'Falta una fuente mineralógica específica de esta surgencia: no se confirma sílice, carbonatos ni una mezcla equivalente a Home Plate sin análisis local.',
   null),
  ('laguna-colorada', 'mineralogical',
   'F4 sugiere estudiar depósitos de boratos como punto de partida para preguntas sobre el boro en ambientes lacustres. Respaldo: sugerido.',
   'Detectar boro en Gale no identifica bórax ni demuestra la misma química. Falta una fuente específica que establezca equivalencia entre los minerales de ambos lugares.',
   null),
  ('laguna-colorada', 'environmental',
   'La salinidad y la exposición de un lago alto permiten plantear preguntas de habitabilidad, como sugerencia de F4.',
   'Es un ecosistema terrestre con agua líquida. Falta una fuente específica que cuantifique condiciones comparables; su color o sus organismos no prueban habitabilidad de Gale.',
   null),
  ('laguna-verde', 'mineralogical',
   'Los microbialitos fósiles de sus terrazas permiten estudiar cómo quedan registradas señales biológicas en depósitos de un antiguo lago. Respaldo en F4: estudiado.',
   'Su origen biológico terrestre no demuestra vida en Jezero. La mineralogía y la conservación deben contrastarse muestra por muestra, sin trasladar edades o especies a Marte.',
   'https://doi.org/10.1029/2008JG000818'),
  ('laguna-verde', 'environmental',
   'High-Lakes estudia cómo el frío, la exposición solar y los cambios del agua afectan ecosistemas de lagos altos, incluida Laguna Verde.',
   'El lago conserva agua líquida y vida terrestre. La altitud no reproduce la presión ni el espectro de radiación de Marte; interesa como comparación parcial del Marte antiguo.',
   'https://astrobiology.nasa.gov/nai/annual-reports/2008/objective-4.1/index.html'),
  ('lanzarote-pangaea', 'operational',
   'PANGAEA entrena observación geológica, reconocimiento de rocas y selección y documentación de muestras en terreno volcánico.',
   'Es entrenamiento de métodos bajo aire y gravedad terrestres. No valida por sí solo movilidad con traje presurizado ni operaciones en vacío.',
   'https://www.esa.int/Science_Exploration/Human_and_Robotic_Exploration/CAVES_and_Pangaea/What_is_PANGAEA'),
  ('lanzarote-pangaea', 'geomorphological',
   'Los paisajes volcánicos y tubos de lava permiten reconocer formas y relacionarlas con procesos de erupción.',
   'No reproducen tamaños, conservación ni estabilidad de cavidades lunares. La erosión terrestre y la gravedad modifican el relieve.',
   'https://www.esa.int/Science_Exploration/Human_and_Robotic_Exploration/CAVES_and_Pangaea/What_is_PANGAEA'),
  ('la-salsa', 'mineralogical',
   'Los montículos hidrotermales ricos en calcio y sílice permiten estudiar aportes biológicos y no biológicos a depósitos minerales. Respaldo en F4: estudiado.',
   'La forma del depósito no basta para identificar una biofirma. Los aportes volcánicos, el agua y los microbios actuales no demuestran el mismo proceso en Home Plate.',
   'https://doi.org/10.3390/min9060380'),
  ('la-salsa', 'environmental',
   'El sistema termal permite comparar comunidades y depósitos a lo largo de cambios locales de condiciones físico-químicas.',
   'El aporte de agua y calor sostiene vida terrestre actual. No representa la presión ni el ambiente seco de Marte hoy, ni confirma vida antigua allí.',
   'https://doi.org/10.3390/min9060380'),
  ('licancabur', 'environmental',
   'High-Lakes estudia respuestas de ecosistemas lacustres de altura al frío, la irradiancia solar y cambios rápidos del ambiente. Respaldo en F4: estudiado.',
   'Las condiciones cambian entre lagos y campañas. Hay agua y vida terrestre; la altura no reproduce la presión marciana ni su radiación ionizante. La comparación se orienta a lagos antiguos.',
   'https://astrobiology.nasa.gov/nai/annual-reports/2008/objective-4.1/index.html'),
  ('licancabur', 'mineralogical',
   'Los sedimentos y depósitos de antiguos niveles lacustres permiten investigar cómo se guardan señales de cambios del lago.',
   'El conjunto reúne varios lagos con química distinta; no se extiende la mineralogía de Laguna Verde al lago del cráter. Cada comparación con Marte necesita análisis propios.',
   'https://doi.org/10.1029/2008JG000818'),
  ('mcmurdo', 'environmental',
   'El catálogo utiliza los Valles Secos como ambiente polar árido para estudiar disponibilidad de agua y suelos congelados.',
   'Hay aire terrestre y agua líquida estacional en algunos sectores. No equivale a Marte ni a una sombra lunar permanente. Falta una fuente específica de condiciones medidas para esta ficha.',
   null),
  ('mcmurdo', 'geomorphological',
   'Los suelos con patrones y el relieve ligado al hielo permiten comparar formas de terrenos fríos, según el catálogo.',
   'El parecido de polígonos no demuestra igual mecanismo o contenido de hielo. Falta una fuente específica que compare el sector elegido con una zona marciana.',
   null),
  ('mdrs', 'operational',
   'La estación se usa como simulación de misión: convivencia, trabajo de campo y coordinación científica de tripulaciones.',
   'La atmósfera y la gravedad siguen siendo terrestres. Cada campaña fija sus reglas; no se supone que todas incluyan demora de enlace o los mismos equipos.',
   'https://mdrs.marssociety.org/'),
  ('mdrs', 'geomorphological',
   'El catálogo destaca capas y afloramientos sedimentarios del desierto de Utah para practicar lectura del terreno.',
   'La erosión terrestre y los materiales locales no equivalen a los de una zona marciana por el aspecto del paisaje. Falta una fuente específica que valide esa comparación geológica.',
   null),
  ('meteor-crater', 'geomorphological',
   'Su borde, cavidad y materiales expulsados permiten estudiar la forma de un cráter de impacto simple.',
   'No reproduce el pico central y las estructuras de grandes cráteres complejos como Tycho. La erosión y la gravedad son terrestres.',
   'https://www.usgs.gov/centers/astrogeology-science-center/science/meteor-crater-sample-collection'),
  ('meteor-crater', 'operational',
   'Se puede practicar reconocimiento de impactos y selección de observaciones; USGS documenta el entrenamiento histórico de astronautas Apollo en este sitio.',
   'La práctica propuesta debe ajustarse al acceso autorizado. El precedente histórico no demuestra que se hayan hecho los mismos ejercicios actuales ni reproduce una EVA en vacío.',
   'https://www.usgs.gov/centers/astrogeology-science-center/science/meteor-crater-sample-collection'),
  ('ollague', 'geomorphological',
   'F4 sugiere comparar domos y coladas poco erosionados en clima árido. Respaldo: sugerido.',
   'Ollagüe es un estratovolcán andino; no reproduce la arquitectura ni escala del escudo Olympus Mons. Falta una fuente específica que valide esta comparación planetaria.',
   null),
  ('pastos-grandes', 'mineralogical',
   'F4 recoge depósitos de carbonatos y microbialitos ligados a aguas termales como comparación para estudiar preservación de señales de vida. Respaldo: estudiado.',
   'La asociación de carbonatos y microbios en Bolivia no determina el origen de los carbonatos de Jezero. Deben separarse precipitación química y aportes biológicos.',
   'https://doi.org/10.3390/min9060380'),
  ('pastos-grandes', 'environmental',
   'El agua termal y los cambios locales de salinidad permiten estudiar hábitats en una cuenca volcánica de altura.',
   'El sistema recibe agua y calor en la actualidad bajo atmósfera terrestre. No equivale al ambiente marciano actual ni demuestra que su antiguo lago estuviera habitado.',
   'https://doi.org/10.3390/min9060380'),
  ('permafrost-occidental', 'environmental',
   'F4 sugiere investigar conservación de suelo congelado en sectores altos de la Cordillera Occidental. Respaldo: sugerido.',
   'Congelarse una noche no demuestra permafrost: el suelo debe permanecer a 0 °C o menos al menos dos años consecutivos. Falta una serie térmica local; la altura no iguala la presión de Marte.',
   null),
  ('permafrost-occidental', 'geomorphological',
   'F4 sugiere comparar formas de suelo ordenado por procesos de congelación y deshielo.',
   'Falta una fuente específica y verificación local del mecanismo. Ver patrones superficiales no demuestra hielo permanente ni equivalencia con los polígonos marcianos.',
   null),
  ('rio-tinto', 'mineralogical',
   'El catálogo compara minerales de hierro y sulfatos de un sistema ácido con la alteración observada en Meridiani Planum.',
   'El agua, la actividad microbiana y la minería intervienen en el sistema terrestre. Falta una fuente específica para contrastar las fases minerales de esta ficha con las marcianas.',
   null),
  ('rio-tinto', 'environmental',
   'El agua ácida rica en hierro permite formular preguntas sobre vida en ambientes químicamente extremos, según el catálogo.',
   'La acidez no reproduce por sí sola el frío, la presión ni la radiación de Marte. Falta una fuente específica de la comparación; la vida local no demuestra vida marciana.',
   null),
  ('sajama', 'operational',
   'F2 propone pruebas de baterías, estabilidad y procedimientos de campo en sectores volcánicos de altura. Es candidato por procesos.',
   'No se afirma que los ensayos ya se hicieron: falta una fuente de campaña específica. Se requieren permisos y caracterización del sector; frío y altura terrestres no certifican equipos para Marte.',
   null),
  ('sajama', 'geomorphological',
   'F2 propone aprovechar pendientes, rocas y superficies volcánicas para comparar problemas de recorrido.',
   'No todos los materiales son basálticos ni equivalen al regolito marciano. Falta una fuente específica de caracterización del sector y no se traslada la tracción terrestre sin ajustes.',
   null),
  ('sajama', 'environmental',
   'F2 propone caracterizar frío, oscilación térmica y exposición solar para estudiar respuestas de materiales y equipos.',
   'Falta una fuente específica con mediciones del ensayo. La presión de altura sigue siendo mucho mayor que la de Marte y el UV no reproduce las partículas de la radiación espacial.',
   null),
  ('sajama-hielo', 'geomorphological',
   'Las capas de hielo del Sajama guardan un registro climático; F4 sugiere la comparación conceptual con archivos de hielo polar marciano. Respaldo: sugerido.',
   'El estudio citado trata del Sajama y no valida por extensión todo el Illimani. La acumulación y conservación terrestres difieren de las capas de hielo y polvo marcianas.',
   'https://doi.org/10.1126/science.282.5395.1858'),
  ('sajama-hielo', 'environmental',
   'F4 sugiere usar glaciares altos como comparación parcial de conservación de hielo y respuesta al clima.',
   'Hay nieve, posible fusión y aire terrestre; no se reproduce el balance energético polar de Marte. Falta una fuente ambiental específica para ambos glaciares y sus condiciones locales.',
   null),
  ('salares-capas', 'geomorphological',
   'La alternancia de capas salinas y sedimentos lacustres permite leer cambios entre periodos húmedos y secos. Respaldo en F4: estudiado.',
   'Las capas terrestres no reproducen toda la edad, extensión ni historia de enterramiento del Monte Sharp. La semejanza de estratos no demuestra una secuencia climática idéntica.',
   'https://science.nasa.gov/earth/earth-observatory/bolivian-salt-flats-151813/'),
  ('salares-capas', 'mineralogical',
   'Sales y sedimentos finos permiten comparar depósitos de evaporación y episodios con mayor presencia de agua.',
   'Cada capa necesita análisis mineralógico. No toda capa clara es yeso ni se deducen percloratos por semejanza con Marte.',
   'https://science.nasa.gov/earth/earth-observatory/bolivian-salt-flats-151813/'),
  ('salda', 'mineralogical',
   'Los carbonatos del lago permiten estudiar precipitación mineral y conservación de señales en comparación con depósitos de Jezero.',
   'Salda tiene agua y vida actuales. No se demuestra que los carbonatos marcianos tengan el mismo origen ni idéntica composición.',
   'https://science.nasa.gov/blogs/earth-matters/2021/02/17/what-a-lake-in-turkey-can-tell-us-about-mars/'),
  ('salda', 'geomorphological',
   'Las orillas, depósitos de costa y deltas permiten comparar relaciones entre relieve, aporte de sedimentos y nivel del lago.',
   'Jezero es una cuenca de impacto con una historia antigua distinta. La geometría del lago terrestre no basta para reconstruir el caudal o la duración del lago marciano.',
   'https://science.nasa.gov/blogs/earth-matters/2021/02/17/what-a-lake-in-turkey-can-tell-us-about-mars/'),
  ('siloli', 'geomorphological',
   'F4 propone comparar rocas esculpidas por erosión en un desierto alto, incluido el Árbol de Piedra. Respaldo: propuesto.',
   'Falta una fuente específica que cuantifique el aporte del viento frente al agua y las heladas. Una forma parecida no implica igual mecanismo de erosión que en Marte.',
   null),
  ('siloli', 'environmental',
   'F4 propone el frío y la sequedad de altura como combinación parcial de factores ambientales de interés.',
   'Falta una fuente específica de mediciones locales. La atmósfera y la humedad son terrestres; ni la altura ni el UV igualan presión y radiación ionizante marcianas.',
   null),
  ('sol-de-manana', 'mineralogical',
   'F4 sugiere estudiar la alteración de materiales por fluidos y gases hidrotermales. Respaldo: sugerido.',
   'Falta una fuente mineralógica específica del punto de muestreo. No se confirma sílice o sulfatos concretos sin análisis; un sistema activo no reproduce la historia del depósito de Home Plate.',
   null),
  ('sol-de-manana', 'environmental',
   'F4 sugiere investigar contrastes entre fluidos calientes y ambiente frío de altura para preguntas sobre habitabilidad.',
   'Falta una fuente específica de condiciones y comunidades locales. Agua caliente, gases y costras frágiles restringen el acceso; la presión sigue siendo terrestre, no marciana.',
   null),
  ('sud-lipez', 'operational',
   'F2 propone movilidad y navegación de rovers entre arena, grava y rocas en sectores autorizados de la reserva.',
   'Es una propuesta sin fuente específica de campaña. Deben excluirse fumarolas y lagunas sensibles; el suelo, la gravedad y la atmósfera no reproducen una misión marciana.',
   null),
  ('sud-lipez', 'geomorphological',
   'F2 propone usar la variedad de terrenos volcánicos y sedimentarios para reconocer obstáculos y planear rutas.',
   'Falta una fuente específica del sector seleccionado. Un mosaico terrestre no representa una sola unidad geológica marciana; cambian materiales, escala y procesos de erosión.',
   null),
  ('sud-lipez', 'environmental',
   'El frío, la aridez y la exposición solar son factores que F2 propone registrar durante pruebas de campo.',
   'Falta una fuente específica con mediciones por sitio y fecha. No se generalizan condiciones de una laguna a toda la reserva; la altura no reproduce presión ni radiación espacial de Marte.',
   null),
  ('tajzara', 'geomorphological',
   'F4 propone estudiar formas y transporte de arena en dunas de altura. Respaldo: propuesto.',
   'La densidad del aire, la gravedad y los granos controlan el transporte; no se trasladan velocidades de viento a Marte directamente. Falta una fuente específica de la comparación.',
   null),
  ('tajzara', 'environmental',
   'F4 propone el entorno árido de altura para investigar condiciones ambientales y posibles hábitats en arena.',
   'F4 señala una oportunidad de investigación microbiológica, no un resultado demostrado. Falta una fuente específica verificada; no se igualan presión, agua disponible o radiación con Marte.',
   null),
  ('tata-sabaya', 'geomorphological',
   'F4 sugiere comparar los montículos del depósito de avalancha de un flanco volcánico con grandes movimientos de ladera. Respaldo: sugerido.',
   'El estudio geológico terrestre no valida una equivalencia con todos los deslizamientos marcianos. Cambian el volumen, la gravedad y el contexto; deben contrastarse las geometrías.',
   'https://doi.org/10.5027/andgeoV39n3-a03'),
  ('torotoro', 'operational',
   'F2 propone practicar lectura de estratos, fotografía con escala y selección de observaciones geológicas. F4 lo mantiene como sugerido.',
   'Falta una fuente específica de entrenamiento ya realizado. La práctica exige permisos y protección del patrimonio; no reproduce limitaciones de un traje ni comunicaciones de una misión espacial.',
   null),
  ('torotoro', 'geomorphological',
   'Las paredes del cañón y sus capas permiten comparar relaciones entre estratos y erosión, como sugerencia de F4.',
   'El cañón fluvial no reproduce la apertura tectónica ni la escala de Valles Marineris. Falta una fuente específica que valide esta comparación planetaria.',
   null),
  ('umajalanta', 'operational',
   'F4 sugiere navegación, cartografía y comunicaciones en una cavidad como práctica posible. Respaldo: sugerido.',
   'Falta una fuente específica de ensayos. Es una cueva de caliza formada por agua, no un tubo de lava. Aire, humedad, acceso y estabilidad difieren de una cavidad lunar.',
   null),
  ('uyuni', 'mineralogical',
   'Sales, salmueras y sedimentos permiten comparar procesos de evaporación. F4 conserva el sitio como propuesto por NASA para una comparación marciana.',
   'No se atribuyen percloratos sin análisis local. La mezcla y edad de las sales no se trasladan directamente a Aureum Chaos.',
   'https://science.nasa.gov/earth/earth-observatory/bolivian-salt-flats-151813/'),
  ('uyuni', 'environmental',
   'F4 recoge frío, sequedad y salinidad como factores de interés para estudiar ambientes salinos. Respaldo: propuesto por NASA.',
   'Falta una fuente específica de mediciones ambientales de esta ficha. La inundación estacional y la atmósfera terrestre permiten agua líquida; la altura no reproduce la presión ni la radiación de Marte.',
   null),
  ('uyuni-icaria', 'mineralogical',
   'El trabajo EPSC 2024 compara distribución y formación de depósitos de cloruros en Icaria Planum con Uyuni. Respaldo en F4: estudiado.',
   'Es una comparación presentada en congreso, no identidad mineral completa ni prueba de vida. Los depósitos marcianos están retrabajados; no se deducen percloratos en Uyuni de esta comparación.',
   'https://doi.org/10.5194/epsc2024-483'),
  ('uyuni-navegacion', 'operational',
   'F2 propone probar localización visual y cartografía en superficies planas y repetitivas, usando GNSS solo como referencia externa si el ensayo lo requiere.',
   'Falta una fuente específica de pruebas realizadas. Debe comprobarse la costra y operar en sectores autorizados; salmuera e inundación cambian la movilidad y no reproducen el suelo marciano.',
   null),
  ('uyuni-poligonos', 'geomorphological',
   'F4 recoge los polígonos salinos y el modelo de convección de salmuera como ejemplo de patrones que pueden parecerse con orígenes distintos. Respaldo: estudiado.',
   'El patrón no prueba hielo ni permafrost. El estudio de convección no demuestra que ese mecanismo opere en cada polígono de Uyuni ni en los polígonos de Marte.',
   'https://doi.org/10.1103/PhysRevX.13.011025'),
  ('uyuni-salmueras', 'environmental',
   'F4 recoge las salmueras como medio para estudiar límites de habitabilidad por salinidad y poca agua disponible. Respaldo: estudiado.',
   'Falta una fuente microbiológica específica verificada para esta ficha. No se atribuyen comunidades o tolerancias a toda la cuenca. Las RSL no prueban salmueras ni agua líquida actual en Marte.',
   null),
  ('uyuni-salmueras', 'mineralogical',
   'F4 recoge el interés de comparar sales disueltas y precipitados de las salmueras con ambientes evaporíticos.',
   'Falta una fuente analítica específica del punto muestreado. No se asumen igual concentración ni mezcla en toda la cuenca; no se atribuyen percloratos sin detección local.',
   null),
  ('valle-de-la-luna', 'operational',
   'F2 propone usar imágenes o modelos digitales de cárcavas y pináculos para practicar fotogrametría, cartografía y navegación.',
   'Es un candidato metodológico, sin fuente específica de ensayos realizados. Las formaciones son frágiles: se priorizan réplicas o modelos; no se validan ruedas o trajes para Marte con un mapa.',
   null),
  ('valle-de-la-luna', 'geomorphological',
   'F2 propone reconocer cárcavas, pendientes y sombras como ejercicio de interpretación del relieve.',
   'La erosión por agua de materiales blandos no reproduce por sí sola procesos de Gale ni cráteres lunares. Falta una fuente específica de comparación; el nombre del lugar no demuestra equivalencia geológica.',
   null)
on conflict (analog_id, category) do update set
  covers = excluded.covers,
  breaks = excluded.breaks,
  source = excluded.source;
