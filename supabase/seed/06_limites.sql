-- =====================================================================
-- 06 · LÍMITES POR TIPO DE ANALOGÍA                         Dueño: Maldo
-- =====================================================================
-- Qué reproduce cada análogo y dónde se rompe, por cada tipo de analogía que cumple.
-- Tabla: analog_aspects (supabase/migrations/20261116000000_profundizacion.sql)
--
--   analog_id  id del análogo
--   category   geomorphological | mineralogical | environmental | operational
--   covers     qué reproduce el sitio en esa categoría
--   breaks     dónde deja de servir la analogía en esa categoría
--   source     enlace específico de ese límite, o null si vale la fuente del análogo
--
-- Una fila por cada categoría que el análogo cumple: la principal y las de "en parte"
-- (05_analogias_quiebre.sql). Las categorías sin fila se muestran en la app como "No cubre".
-- environmental = condiciones para la vida (frío, aridez, UV, salinidad, presión, radiación).
-- operational   = qué se puede practicar ahí (astronautas, rovers, trajes, hábitats).
--
-- Criterios usados:
--   * Complementa el "punto de quiebre" de 05 (resumen) separándolo por categoría.
--   * Datos de CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md, F2 y F4 (tmp/lectura/) y las fuentes de
--     cada análogo (02_analogs.sql). Sección 12 del contexto respetada: la altura no reproduce la
--     presión de Marte (600–900 Pa frente a 54.000–72.000 Pa en el Altiplano), no hay percloratos
--     comprobados en Uyuni, las comparaciones de forma no implican el mismo origen.
--   * Presión: "decenas de veces mayor" en sitios de altura; "más de cien veces" cerca del nivel del mar.
--   * source en null: vale la fuente del análogo.
--
-- Reglas de contenido (README y CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md, sección 12):
--   * Nada sin fuente real. Lenguaje sencillo. Comillas simples dentro del texto se escriben dobles.
-- Después de editar: bash supabase/seed/exportar-json.sh  (regenera src/data/*.json)
-- Los análogos nuevos de Miguel llevan sus límites en 09_analogos_nuevos.sql.

insert into public.analog_aspects (analog_id, category, covers, breaks, source) values

  -- ---------------------------------------------------------------- atacama (amb + min)
  ('atacama', 'environmental',
   'Aridez extrema, radiación UV alta y suelos donde la vida microbiana es escasa: sirve para probar cómo buscar vida en el límite de lo habitable.',
   'La presión del aire es unas 100 veces la de Marte, hay oxígeno y el campo magnético frena los rayos cósmicos. Incluso en sus zonas más secas hay humedad nocturna y microbios.',
   null),
  ('atacama', 'mineralogical',
   'Suelos con sales y sulfatos y, en zonas como Yungay, percloratos: sales que también se encontraron en el suelo de Marte.',
   'Esas sales se formaron con la niebla y la atmósfera terrestres, en millones de años, no en los miles de millones de Meridiani. No reproduce las esférulas de hematita de Meridiani.',
   null),

  -- ---------------------------------------------------------------- basalt (op + geo, min)
  ('basalt', 'operational',
   'Caminatas geológicas coordinadas con un equipo científico remoto, con comunicaciones demoradas y decisiones bajo límites de tiempo y energía.',
   'La demora de las comunicaciones es simulada y el trabajo se hace con la gravedad, el aire y la temperatura de la Tierra.',
   null),
  ('basalt', 'geomorphological',
   'Coladas, conos y tubos de lava basáltica, parecidos a los rasgos volcánicos de los mares lunares y de Tharsis.',
   'Las coladas de Idaho son pequeñas frente a las de Tharsis, y faltan los cráteres de impacto que cubren la Luna. En la Luna no hay viento ni agua que modifiquen el relieve.',
   null),
  ('basalt', 'mineralogical',
   'Roca basáltica, el tipo de roca más común en la superficie de la Luna y de Marte.',
   'El basalto terrestre se altera con agua y oxígeno. El lunar es muy seco, y el regolito de la Luna y de Marte es polvo y roca triturados por impactos durante miles de millones de años.',
   null),

  -- ---------------------------------------------------------------- canapa (amb)
  ('canapa', 'environmental',
   'Salmuera hipersalina y fría en altura, con radiación UV alta: un ambiente para preguntar cómo sobrevive la vida en la sal.',
   'Es un ecosistema abierto, con aves y microbios que llegan de fuera; en Marte no hay vida conocida que pueda colonizar una salmuera. Sirve para estudiar los límites de la vida, no para predecir si la hay en Marte.',
   null),

  -- ---------------------------------------------------------------- cerro-rico (min)
  ('cerro-rico', 'mineralogical',
   'Drenaje ácido con sulfatos de hierro. En sus relaves conviene buscar minerales como jarosita y schwertmannita, que indican agua ácida como en Meridiani.',
   'Su química ácida la causó la minería, al exponer sulfuros al aire y al agua; en Meridiani se formó de forma natural hace miles de millones de años. Falta confirmar esos minerales con análisis.',
   null),

  -- ---------------------------------------------------------------- coipasa (min + op)
  ('coipasa', 'mineralogical',
   'Costras de sal, salmueras y arcillas formadas por evaporación, en una cuenca distinta de Uyuni: permite comparar dos salares.',
   'Su sal es reciente y se moja con las lluvias; los depósitos de Aureum Chaos e Icaria Planum son antiguos y secos. La equivalencia debe demostrarse con análisis mineral, no por apariencia.',
   null),
  ('coipasa', 'operational',
   'Superficie salina para comparar la navegación y la clasificación de terreno de un mismo rover con lo medido en Uyuni.',
   'No debe darse por firme ni accesible, y la gravedad y la tracción son las terrestres. Hay que evitar costras y ecosistemas frágiles.',
   null),

  -- ---------------------------------------------------------------- concordia (op + amb)
  ('concordia', 'operational',
   'Aislamiento de meses con una tripulación pequeña, frío y oscuridad invernal, como en una base de larga duración.',
   'Se vive sin traje, respirando aire, con una gravedad unas seis veces la lunar. No hay vacío ni regolito, ni la radiación de la superficie lunar.',
   null),
  ('concordia', 'environmental',
   'Frío extremo, aire muy seco y oscuridad durante el invierno polar.',
   'El polo sur lunar no tiene atmósfera: sus sombras permanentes son mucho más frías y la radiación llega sin el escudo del aire ni del campo magnético.',
   null),

  -- ---------------------------------------------------------------- cordillera-real (amb + geo)
  ('cordillera-real', 'environmental',
   'Hielo expuesto a mucha radiación solar en un ambiente frío y de altura, que se pierde año a año.',
   'El hielo se pierde sobre todo derritiéndose, con agua líquida. En Planum Boreum se pierde por sublimación, a una presión de cientos de pascales y muy bajo cero.',
   null),
  ('cordillera-real', 'geomorphological',
   'Terreno nuevo que queda al descubierto cuando el glaciar retrocede: morrenas y rocas pulidas por el hielo.',
   'Son glaciares de montaña. Planum Boreum es un casquete de capas de hielo y polvo cuyo relieve marcan la sublimación y el viento.',
   null),

  -- ---------------------------------------------------------------- desierto-dali (amb + geo)
  ('desierto-dali', 'environmental',
   'Desierto frío, seco y de altura, con radiación UV alta, donde aún no se ha estudiado qué vida microbiana hay.',
   'Su frío y su aridez son moderados frente a Marte, y tiene oxígeno y una presión decenas de veces mayor. Sin estudios microbiológicos, la analogía es una propuesta.',
   null),
  ('desierto-dali', 'geomorphological',
   'Paisaje árido de arena y rocas aisladas modelado por el viento.',
   'Medusae Fossae es un depósito fino y blando de cientos de kilómetros tallado en crestas (yardangs). Dalí es mucho más pequeño y de otro material.',
   null),

  -- ---------------------------------------------------------------- el-tatio (min + amb)
  ('el-tatio', 'mineralogical',
   'Depósitos de sílice formados por aguas termales, como la sílice que encontró el rover Spirit cerca de Home Plate.',
   'Su sílice se sigue formando hoy con agua hirviendo; la de Home Plate es antigua. La vida actual de El Tatio deja señales que complican distinguir biofirmas antiguas.',
   null),
  ('el-tatio', 'environmental',
   'Agua termal en altura, con frío nocturno y radiación UV alta, donde viven microbios adaptados.',
   'Hay agua líquida, oxígeno y presión terrestre. Home Plate hoy está seco y expuesto a la radiación marciana sin protección.',
   null),

  -- ---------------------------------------------------------------- glaciares-roca (geo + amb)
  ('glaciares-roca', 'geomorphological',
   'Hielo protegido por una capa de rocas y detritos que frena su pérdida, con frentes y lóbulos como los de los glaciares de Deuteronilus Mensae.',
   'Son mucho más pequeños y su hielo se renueva con nieve. Los glaciares de Marte son restos de climas antiguos y se mueven con 0,38 veces la gravedad terrestre.',
   null),
  ('glaciares-roca', 'environmental',
   'Ambiente seco y frío de altura donde son la principal reserva de hielo de la Cordillera Occidental.',
   'En verano superan los 0 °C y hay agua líquida. En Deuteronilus Mensae el hielo está siempre bajo cero y a una presión muy baja.',
   null),

  -- ---------------------------------------------------------------- grand-canyon (geo)
  ('grand-canyon', 'geomorphological',
   'Paredes de cientos de metros con capas expuestas y deslizamientos, que permiten leer la historia geológica como en las paredes de Valles Marineris.',
   'Sus capas son rocas de antiguos mares y ríos, con fósiles; las paredes de Valles Marineris se interpretan en buena parte como coladas volcánicas y depósitos cuyo origen aún se discute. Comparar capas no dice cómo se formaron.',
   null),

  -- ---------------------------------------------------------------- guapore (min)
  ('guapore', 'mineralogical',
   'Corteza precámbrica muy antigua, útil para estudiar cómo se altera una roca vieja con el paso del tiempo.',
   'Se meteoriza en clima tropical, con lluvia, vegetación y vida en el suelo. Las arcillas de Mawrth Vallis se formaron con agua hace miles de millones de años, sin vida conocida. Es un análogo sugerido, sin estudios.',
   null),

  -- ---------------------------------------------------------------- haughton (geo + amb)
  ('haughton', 'geomorphological',
   'Cráter de impacto de unos 23 km con roca fracturada, brechas de impacto y rastros de actividad hidrotermal causada por el impacto.',
   'Se formó en rocas sedimentarias y su levantamiento central está muy erosionado. Tycho se formó en roca lunar seca y conserva pico central, terrazas y charcos de roca fundida por el impacto.',
   null),
  ('haughton', 'environmental',
   'Desierto polar frío y seco, con suelo congelado.',
   'En verano hay agua líquida y vida. La Luna no tiene atmósfera ni agua líquida, y su superficie pasa de mucho calor a mucho frío entre el día y la noche.',
   null),

  -- ---------------------------------------------------------------- haughton-hmp (op + amb)
  ('haughton-hmp', 'operational',
   'Ensayos de vehículos, caminatas con trajes simulados, robots y procedimientos de campo en un lugar remoto y frío.',
   'Se respira aire, la gravedad es terrestre y hay apoyo cercano. En Utopia Planitia harían falta trajes presurizados y las comunicaciones con la Tierra tardan minutos.',
   null),
  ('haughton-hmp', 'environmental',
   'Frío polar, aridez y aislamiento en un entorno sin vegetación.',
   'La presión del aire es más de cien veces la de Marte y en verano hay agua líquida.',
   null),

  -- ---------------------------------------------------------------- hi-seas (op)
  ('hi-seas', 'operational',
   'Vida en un hábitat cerrado durante meses: convivencia, rutinas, comida y salidas planificadas sobre terreno volcánico.',
   'La tripulación respira aire, vive con gravedad terrestre y sabe que puede salir. La demora de las comunicaciones se simula, y no hay radiación ni el riesgo real de una misión.',
   null),

  -- ---------------------------------------------------------------- intersalar (geo)
  ('intersalar', 'geomorphological',
   'Domos de lava planos y amplios mantos de ignimbrita, depósitos de nubes volcánicas ardientes.',
   'Las ignimbritas vienen de erupciones explosivas; Olympus Mons se formó con coladas tranquilas. Antes de usarlo como análogo hay que caracterizar el sitio: no tiene estudios ni fuente.',
   null),

  -- ---------------------------------------------------------------- italia-perdida (geo)
  ('italia-perdida', 'geomorphological',
   'Rocas volcánicas talladas en formas irregulares por la erosión, comparables con las rocas pulidas por el viento que fotografían los rovers.',
   'Son rocas duras y aisladas, no un depósito continuo. Las formas de Medusae Fossae son crestas alargadas, de kilómetros de largo, en un material blando.',
   null),

  -- ---------------------------------------------------------------- iturralde (geo)
  ('iturralde', 'geomorphological',
   'Estructura circular de unos 8 km, muy degradada y casi sin relieve, en sedimentos blandos: así se ven los cráteres «fantasma» de las llanuras del norte de Marte.',
   'Si fue una explosión en el aire, no sería un cráter de impacto propiamente dicho. Los cráteres fantasma de Marte son impactos reales enterrados por lava o sedimentos: hay que confirmar su origen antes de usarlo.',
   null),

  -- ---------------------------------------------------------------- kilauea (min + geo)
  ('kilauea', 'mineralogical',
   'Basalto, el tipo de roca de los mares lunares y de los volcanes de Tharsis.',
   'Su basalto contiene agua y se altera rápido con lluvia y oxígeno. Los basaltos lunares son muy secos y tienen más de 3.000 millones de años.',
   null),
  ('kilauea', 'geomorphological',
   'Volcán en escudo con coladas fluidas, cráteres de hundimiento y tubos de lava, formas que también aparecen en la Luna y en Marte.',
   'Olympus Mons es mucho más alto y ancho. Los domos de Marius Hills se formaron con lava más viscosa que la de los mares, distinta de la de Kīlauea.',
   null),

  -- ---------------------------------------------------------------- lago-poopo (amb + min)
  ('lago-poopo', 'environmental',
   'Lago de altura que se seca: muestra cómo cambian la salinidad y la vida cuando un lago desaparece.',
   'Al secarse murieron peces y aves, y la vida que quedó se adaptó a un agua cada vez más salada; en Jezero no se sabe si hubo vida. Sirve para ver qué rastros quedan, no para reconstruir el ambiente marciano.',
   null),
  ('lago-poopo', 'mineralogical',
   'Costras de sal y sedimentos que quedan en el fondo al evaporarse el agua.',
   'Son depósitos recientes y húmedos. Los del lago de Jezero son antiguos, compactados y alterados durante miles de millones de años.',
   null),

  -- ---------------------------------------------------------------- lago-tauca (geo + min)
  ('lago-tauca', 'geomorphological',
   'Antiguas orillas y terrazas que marcan los niveles que tuvo un gran lago.',
   'Sus orillas antiguas son líneas de playa de un lago tranquilo. Aureum Chaos muestra bloques hundidos y fracturados por el colapso del suelo, una forma que el Altiplano no tiene.',
   null),
  ('lago-tauca', 'mineralogical',
   'Sus depósitos de sal y yeso, hoy los salares, muestran qué queda cuando se evapora un gran lago.',
   'La sal es reciente y se moja cada año. Los depósitos de Aureum Chaos son antiguos y su composición debe confirmarse con análisis.',
   null),

  -- ---------------------------------------------------------------- laguna-blanca-termal (amb + min)
  ('laguna-blanca-termal', 'environmental',
   'Agua termal de unos 36 °C a más de 4.300 m, con microbios que soportan frío, UV alta y cambios bruscos.',
   'Su calor viene de la actividad volcánica actual. En Home Plate esa fuente de calor se apagó hace miles de millones de años, así que sirve para imaginar el pasado, no el presente.',
   null),
  ('laguna-blanca-termal', 'mineralogical',
   'Depósitos minerales que dejan las aguas termales al enfriarse.',
   'No hay estudios que comparen su mineralogía con la de Home Plate, rica en sílice: la comparación mineral está por confirmar.',
   null),

  -- ---------------------------------------------------------------- laguna-colorada (min + amb)
  ('laguna-colorada', 'mineralogical',
   'Laguna hipersalina con islas de bórax, un mineral de boro. El rover Curiosity detectó boro en vetas del cráter Gale.',
   'El bórax permite formular preguntas sobre el boro, no prueba que los minerales de Gale sean iguales. En Gale el boro está en vetas de sulfato dentro de roca antigua.',
   null),
  ('laguna-colorada', 'environmental',
   'Agua muy salada, fría y con radiación UV alta, donde viven algas con pigmentos.',
   'Es un lago vivo, con algas y flamencos, agua líquida abundante y presión terrestre. Gale hoy está seco.',
   null),

  -- ---------------------------------------------------------------- laguna-verde (min + amb)
  ('laguna-verde', 'mineralogical',
   'Terrazas con microbialitos, rocas de carbonato construidas por microbios, que registran cómo bajó el nivel del lago.',
   'En Jezero hay carbonatos, pero no se ha demostrado que tengan forma de microbialito. Y encontrar esa forma no bastaría para probar vida.',
   null),
  ('laguna-verde', 'environmental',
   'Laguna somera de altura sin refugio contra la radiación UV y con temperaturas del agua muy variables.',
   'Tiene oxígeno, agua estable y presión terrestre. Representa un lago antiguo de Marte, no el ambiente marciano actual.',
   null),

  -- ---------------------------------------------------------------- la-salsa (min + amb)
  ('la-salsa', 'mineralogical',
   'Montículos hidrotermales con carbonato y sílice juntos, un tipo de depósito que puede conservar señales de vida.',
   'La sílice de Home Plate se formó probablemente con vapor o agua caliente sobre roca volcánica; La Salsa combina carbonato y sílice dentro de un lago. La comparación química exacta está por hacer.',
   null),
  ('la-salsa', 'environmental',
   'Fuente termal en altura con microbios que viven en condiciones cambiantes de temperatura y química.',
   'Es un ambiente habitado hoy, con agua y oxígeno. Home Plate está seco desde hace miles de millones de años.',
   null),

  -- ---------------------------------------------------------------- lanzarote-pangaea (op + geo)
  ('lanzarote-pangaea', 'operational',
   'Entrenamiento de astronautas en geología de campo: reconocer rocas volcánicas, tomar muestras y describirlas a un equipo remoto.',
   'Se hace con aire, gravedad terrestre y sin trajes presurizados. En la Luna cada salida está limitada por el traje, el tiempo y la energía.',
   null),
  ('lanzarote-pangaea', 'geomorphological',
   'Coladas de lava, conos y tubos volcánicos, formas que también existen en la Luna.',
   'La lluvia, el viento y la vegetación modifican el relieve. Se cree que los tubos de lava lunares serían mucho más grandes por la baja gravedad.',
   null),

  -- ---------------------------------------------------------------- licancabur (amb + min)
  ('licancabur', 'environmental',
   'Lagos a gran altura con frío, radiación UV muy alta y organismos adaptados, estudiados por el proyecto High-Lakes como modelo de lagos marcianos antiguos.',
   'Su radiación UV es alta para la Tierra, pero el ozono y la atmósfera aún filtran parte de ella. En la superficie de Marte llega mucha más UV, incluida la UV-C.',
   null),
  ('licancabur', 'mineralogical',
   'Química del agua y sedimentos de lagos volcánicos de altura.',
   'Son sedimentos recientes con vida actual. Los de Gale y Jezero son roca antigua y compactada.',
   null),

  -- ---------------------------------------------------------------- mcmurdo (amb + geo)
  ('mcmurdo', 'environmental',
   'Uno de los lugares más fríos y secos de la Tierra, con suelos congelados y muy poca vida.',
   'Recibe luz solar normal, mientras que el fondo de Shackleton está en sombra permanente y es mucho más frío. Y frente a Utopia Planitia, falta la radiación que llega al suelo marciano sin campo magnético.',
   null),
  ('mcmurdo', 'geomorphological',
   'Suelo con polígonos formados por el hielo, parecidos a los de las llanuras del norte de Marte.',
   'Sus polígonos se forman con ciclos de hielo bajo una atmósfera densa. En Marte influyen la sublimación y la baja presión, y ver polígonos no basta para afirmar que hay hielo.',
   null),

  -- ---------------------------------------------------------------- mdrs (op + geo)
  ('mdrs', 'operational',
   'Rutinas completas de misión: salidas con trajes simulados, trabajo en un hábitat pequeño, horarios y reportes a un equipo de apoyo.',
   'Los trajes no están presurizados y se puede salir en cualquier momento. No reproduce la baja presión, la radiación ni la demora real de las comunicaciones.',
   null),
  ('mdrs', 'geomorphological',
   'Terreno sedimentario árido con capas de colores, canales antiguos y suelos arcillosos, parecido a los sedimentos de Jezero y Gale.',
   'Esas capas las formaron ríos y mares terrestres, y hoy las erosiona la lluvia. En Marte esos procesos se detuvieron hace miles de millones de años.',
   null),

  -- ---------------------------------------------------------------- meteor-crater (geo + op)
  ('meteor-crater', 'geomorphological',
   'Cráter de impacto simple de 1,2 km, con borde elevado y eyecta bien conservados.',
   'Tycho mide unos 85 km y tiene pico central y paredes en terrazas, propios de cráteres grandes. Sus rayos de eyecta se conservan porque en la Luna no hay erosión por aire ni agua.',
   null),
  ('meteor-crater', 'operational',
   'Los astronautas del programa Apolo entrenaron aquí para reconocer rocas de impacto.',
   'Entrenaban con aire y gravedad terrestre, sin las limitaciones del traje ni del tiempo de una caminata lunar.',
   null),

  -- ---------------------------------------------------------------- ollague (geo)
  ('ollague', 'geomorphological',
   'Volcán muy bien conservado por la aridez, con domos y coladas casi sin erosión, como los volcanes marcianos.',
   'Es una montaña de casi 6 km sobre el nivel del mar con laderas empinadas; Olympus Mons tiene laderas muy suaves en un escudo enorme. Solo comparte la conservación por el clima seco.',
   null),

  -- ---------------------------------------------------------------- pastos-grandes (min + amb)
  ('pastos-grandes', 'mineralogical',
   'Costra de carbonatos y microbialitos dentro de una caldera, como los carbonatos de un lago dentro de un cráter.',
   'Sus carbonatos se forman en un lago dentro de una caldera volcánica. Jezero es un cráter de impacto con un delta de río, y sus carbonatos pudieron formarse de otras maneras, por ejemplo al alterarse rocas con agua.',
   null),
  ('pastos-grandes', 'environmental',
   'Laguna salina de altura alimentada por fuentes termales, con frío, UV alta y microbios.',
   'Tiene agua líquida, oxígeno y presión terrestre. Jezero dejó de tener agua hace miles de millones de años.',
   null),

  -- ---------------------------------------------------------------- permafrost-occidental (amb + geo)
  ('permafrost-occidental', 'environmental',
   'Suelo congelado de forma permanente por encima de unos 4.700 m, con heladas casi todas las noches.',
   'De día la superficie supera los 0 °C y se descongela. El hielo de Utopia Planitia está casi siempre muy bajo cero y a una presión mínima. Análogo sugerido, sin fuente propia. Para Utopia Planitia es más cercano el permafrost continuo de Yakutia: de −5 a −13 °C y unos 350 m de espesor medio.',
   null),
  ('permafrost-occidental', 'geomorphological',
   'Suelo «ordenado» en pequeños patrones por la helada nocturna.',
   'Son patrones pequeños, de montaña tropical. Los polígonos de Utopia Planitia son mucho mayores y se formaron durante millones de años.',
   null),

  -- ---------------------------------------------------------------- rio-tinto (min + amb)
  ('rio-tinto', 'mineralogical',
   'Agua ácida rica en hierro que forma sulfatos de hierro como la jarosita, un mineral que el rover Opportunity encontró en Meridiani.',
   'Además de jarosita, las rocas de Meridiani tienen esférulas de hematita y arena de basalto cementadas durante miles de millones de años. Río Tinto no reproduce esa mezcla.',
   null),
  ('rio-tinto', 'environmental',
   'Microbios que viven en agua muy ácida y cargada de metales: muestra que la vida tolera condiciones químicas extremas.',
   'Hay agua corriente, oxígeno y temperatura templada. Meridiani hoy es seco, frío y está expuesto a la radiación sin protección.',
   null),

  -- ---------------------------------------------------------------- sajama (op + geo, amb)
  ('sajama', 'operational',
   'Pruebas de rovers y equipos con frío y altura: arranque de baterías, pendientes, estabilidad y procedimientos de campo.',
   'El frío no llega a los extremos marcianos y la presión es decenas de veces mayor. La altura es un riesgo médico para el equipo, no una simulación de Marte.',
   null),
  ('sajama', 'geomorphological',
   'Laderas volcánicas con rocas sueltas de distintos tamaños y obstáculos naturales.',
   'No todos sus materiales son basálticos y el volcán es mucho más pequeño que Olympus Mons. Cada sector requiere comprobación.',
   null),
  ('sajama', 'environmental',
   'Frío de altura, heladas, nieve estacional y radiación UV alta.',
   'Hay oxígeno, la presión es decenas de veces la de Marte y el frío es moderado frente a la temperatura media marciana de unos −59 °C.',
   null),

  -- ---------------------------------------------------------------- sajama-hielo (geo + amb)
  ('sajama-hielo', 'geomorphological',
   'Capas de hielo que guardan un archivo del clima: sus núcleos registran unos 25.000 años.',
   'Es nieve compactada en un glaciar de montaña, que también se derrite. Planum Boreum acumula capas de hielo y polvo durante millones de años.',
   null),
  ('sajama-hielo', 'environmental',
   'Hielo a gran altura, con frío, aire seco y radiación solar intensa.',
   'En Planum Boreum la temperatura es mucho menor, la presión es de cientos de pascales y el hielo se pierde por sublimación.',
   null),

  -- ---------------------------------------------------------------- salares-capas (geo + min)
  ('salares-capas', 'geomorphological',
   'Capas alternadas de sal, yeso y barro que registran épocas secas y húmedas, como las capas del Monte Sharp.',
   'Son capas casi horizontales en una cuenca plana; el Monte Sharp es una montaña de unos 5 km de capas que el viento ha erosionado. Se compara cómo se leen las capas, no su forma.',
   null),
  ('salares-capas', 'mineralogical',
   'Halita y yeso en las capas secas y barro con microfósiles en las húmedas.',
   'En Gale hay arcillas y sulfatos en roca antigua; la comparación mineral exacta requiere análisis.',
   null),

  -- ---------------------------------------------------------------- salda (min + geo)
  ('salda', 'mineralogical',
   'Carbonatos de magnesio y sedimentos parecidos a los de Jezero; el equipo de Perseverance lo usó para preparar la misión.',
   'Sus carbonatos se forman hoy con ayuda de microbios vivos. Los de Jezero son antiguos y su origen biológico no está demostrado.',
   null),
  ('salda', 'geomorphological',
   'Deltas y orillas de un lago, formas que también tiene el antiguo lago de Jezero.',
   'Es un lago con agua; el delta de Jezero es roca antigua que el viento erosiona desde hace miles de millones de años.',
   null),

  -- ---------------------------------------------------------------- siloli (geo + amb)
  ('siloli', 'geomorphological',
   'Rocas esculpidas por el viento, como el Árbol de Piedra, un ventifacto de unos 7 m.',
   'Sus ventifactos son rocas aisladas de unos metros. Medusae Fossae es un depósito continuo y blando tallado en crestas de kilómetros: otra escala y otro material. Para los yardangs de Medusae Fossae hay análogos más directos, como los de la cuenca de Qaidam.',
   null),
  ('siloli', 'environmental',
   'Desierto frío a más de 4.500 m, seco y con radiación UV alta.',
   'Hay oxígeno y vida, y la presión es decenas de veces la de Marte. Medusae Fossae es mucho más fría.',
   null),

  -- ---------------------------------------------------------------- sol-de-manana (min + amb)
  ('sol-de-manana', 'mineralogical',
   'Alteración hidrotermal ácida: fumarolas, barro hirviendo y minerales formados por gases y agua caliente.',
   'Es un sistema activo a presión terrestre. Home Plate es un depósito apagado y muy antiguo, rico en sílice.',
   null),
  ('sol-de-manana', 'environmental',
   'Agua y gases calientes a unos 4.900 m, con mucha radiación UV y poca presión para la Tierra.',
   'Aun así, la presión es decenas de veces la de Marte. Es peligroso: la costra es delgada y se puede caer en barro hirviendo.',
   null),

  -- ---------------------------------------------------------------- sud-lipez (op + geo, amb)
  ('sud-lipez', 'operational',
   'Campo variado para probar suspensión, patinaje, navegación sin GPS y misiones geológicas completas de rovers.',
   'Gravedad y aire terrestres, y suelos distintos del regolito marciano en tamaño de grano y cohesión. Es área protegida: requiere permisos.',
   null),
  ('sud-lipez', 'geomorphological',
   'Mosaico de arena, grava, rocas volcánicas, lagunas y relieve erosionado por el viento.',
   'Su relieve se formó con agua, hielo y volcanes terrestres. Para comparar composiciones hace falta estudiar las rocas de cada sector.',
   null),
  ('sud-lipez', 'environmental',
   'Altura, noches frías, grandes cambios de temperatura y radiación solar intensa.',
   'Los remolinos de polvo terrestres no equivalen a los marcianos, y la presión y el oxígeno son los de la Tierra.',
   null),

  -- ---------------------------------------------------------------- tajzara (geo + amb)
  ('tajzara', 'geomorphological',
   'Dunas de arena a gran altitud que el viento mueve y reforma.',
   'En Medusae Fossae domina la erosión de un depósito blando en crestas (yardangs), no las dunas, y el aire marciano es mucho más tenue.',
   null),
  ('tajzara', 'environmental',
   'Ambiente frío y seco de altura, todavía sin estudios microbiológicos.',
   'Tiene oxígeno, presión terrestre de altura y lagunas cercanas. Sin estudios, la analogía ambiental es una propuesta.',
   null),

  -- ---------------------------------------------------------------- tata-sabaya (geo)
  ('tata-sabaya', 'geomorphological',
   'Avalancha de escombros de unos 6 km³ que cubrió 230–300 km² y dejó montículos, como los grandes deslizamientos de Marte.',
   'Los deslizamientos de Valles Marineris recorren decenas de kilómetros y los flancos de Olympus Mons son mucho mayores. La gravedad terrestre cambia cómo se mueve una avalancha.',
   null),

  -- ---------------------------------------------------------------- torotoro (op + geo)
  ('torotoro', 'operational',
   'Entrenamiento en lectura de estratos: identificar capas y contactos y fotografiarlos con escala, como hacen los equipos de los rovers.',
   'Es una analogía de método, no de rocas. La protección de sus huellas fósiles limita el trabajo físico y la toma de muestras.',
   null),
  ('torotoro', 'geomorphological',
   'Cañón de 250–300 m con capas de lutitas, areniscas y calizas, y un gran pliegue (sinclinal).',
   'Su origen es fluvial y su escala pequeña: Valles Marineris es tectónico y llega a unos 7 km de profundidad. Las rocas de Gale tienen otra edad y composición.',
   null),

  -- ---------------------------------------------------------------- umajalanta (op)
  ('umajalanta', 'operational',
   'Navegación, comunicaciones y mapeo bajo tierra en una cueva de unos 4,6 km.',
   'Sus pasajes son estrechos, húmedos y tienen un río subterráneo; un tubo lunar sería seco, sin aire y quizá mucho más ancho. Equipos y rutas probados aquí deben adaptarse a esas diferencias. Para practicar en tubos de lava reales hay análogos volcánicos como Tolbachik, en Kamchatka.',
   null),

  -- ---------------------------------------------------------------- uyuni (min + amb)
  ('uyuni', 'mineralogical',
   'Costras de sal, salmueras y arcillas hidratadas que la NASA compara con Marte y con Aureum Chaos.',
   'No se le atribuyen percloratos sin análisis local, y su sal es reciente. Los depósitos de Aureum Chaos y Meridiani tienen miles de millones de años. En cambio, en el suelo de Dalangtan (Qaidam, China) sí se detectaron percloratos.',
   null),
  ('uyuni', 'environmental',
   'Frío nocturno, aire seco y radiación UV alta sobre una superficie salina.',
   'Hay oxígeno, la presión es decenas de veces la de Marte y se inunda cada año con agua de lluvia.',
   null),

  -- ---------------------------------------------------------------- uyuni-icaria (min)
  ('uyuni-icaria', 'mineralogical',
   'Cloruros formados por evaporación, comparados por investigadores de la UMSA con los cloruros de Icaria Planum.',
   'Los cloruros de Icaria Planum se detectan desde órbita, con instrumentos que miden la luz que reflejan; los de Uyuni se pueden tocar y analizar. La comparación depende de lo que esos instrumentos logran ver.',
   null),

  -- ---------------------------------------------------------------- uyuni-navegacion (op)
  ('uyuni-navegacion', 'operational',
   'Superficie plana y repetitiva para probar la localización visual, la cartografía y la detección de costras de un rover.',
   'Meridiani tiene ondulaciones de arena y esférulas. La costra puede ocultar salmuera o zonas blandas, y la sal corroe contactos y equipos.',
   null),

  -- ---------------------------------------------------------------- uyuni-poligonos (geo)
  ('uyuni-poligonos', 'geomorphological',
   'Polígonos de 1–2 m que se forman por convección de la salmuera: un contraejemplo de polígonos sin hielo.',
   'No representa los polígonos de hielo de Utopia Planitia. Sirve para no confundir causas, sobre todo en depósitos de sal como los de Icaria Planum. Las costras de sal poligonales de Qaidam (China) permiten comparar este mismo fenómeno en otro salar.',
   null),

  -- ---------------------------------------------------------------- uyuni-salmueras (amb + min)
  ('uyuni-salmueras', 'environmental',
   'Salmueras ricas en litio y magnesio, con sales que desestabilizan biomoléculas, donde viven microbios incluso a 80 m de profundidad.',
   'Sus microbios crecen a temperatura y presión terrestres. Para saber si sobrevivirían en Marte habría que exponerlos en laboratorio a frío extremo, baja presión y radiación. Para Marte se usa como referencia −25 °C o más y una actividad del agua mayor que 0,5; habría que medir esos valores en Uyuni.',
   null),
  ('uyuni-salmueras', 'mineralogical',
   'Química de salmueras con cloruros y sales de litio y magnesio.',
   'En Marte las salmueras podrían incluir percloratos, que no se han medido en Uyuni. La composición de las salmueras marcianas se infiere, no se ha medido directamente.',
   null),

  -- ---------------------------------------------------------------- valle-de-la-luna (op + geo)
  ('valle-de-la-luna', 'operational',
   'Cárcavas, pináculos y sombras para practicar fotogrametría, mapeo 3D y detección de obstáculos.',
   'Las formaciones son frágiles: conviene usar modelos digitales o réplicas. No reproduce la luz, el polvo ni la gravedad de Marte.',
   null),
  ('valle-de-la-luna', 'geomorphological',
   'Relieve erosionado en cárcavas y pináculos sobre sedimentos blandos.',
   'Sus pináculos miden pocos metros y son frágiles; las formas de Gale son de roca más dura y antigua. Sirve para practicar cómo se ve el relieve, no para entender cómo se formó.',
   null)

on conflict (analog_id, category) do update set
  covers = excluded.covers, breaks = excluded.breaks, source = excluded.source;
