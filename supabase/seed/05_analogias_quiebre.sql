-- Para cada análogo: qué otras analogías cumple en parte y cuál es su punto de quiebre.
-- * La analogía a la que más se acerca es su `category` (02_analogs.sql).
-- * secondary_categories: otras de las 4 analogías que cumple de forma parcial.
-- * breaking_point: lo que el sitio no llega a representar del lugar de la Luna o Marte con el que se compara.
--   Sigue CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md, sobre todo la sección 12 (diferencias que requieren cuidado).

update public.analogs set
  secondary_categories = array['mineralogical'],
  breaking_point = 'Tiene aire denso con oxígeno, gravedad terrestre y la protección del campo magnético: la radiación que llega es sobre todo UV, no los rayos cósmicos que recibe Meridiani. Incluso en su zona más seca hay humedad nocturna y vida microbiana.'
where id = 'atacama';

update public.analogs set
  secondary_categories = array['geomorphological', 'mineralogical'],
  breaking_point = 'Ensaya procedimientos y comunicaciones demoradas, pero con la gravedad, el aire y la temperatura de la Tierra. La demora se simula, y el basalto de Idaho no tiene la historia de impactos ni el polvo de la Luna o de Marte.'
where id = 'basalt';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Es agua líquida abundante y estable, con vida terrestre. En Marte las salmueras serían escasas, temporales y a una presión muchísimo menor. Todavía no tiene estudios microbiológicos: la analogía es una propuesta.'
where id = 'canapa';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Su química ácida viene de casi 500 años de minería, no de un proceso natural. Meridiani se alteró sin intervención humana, hace miles de millones de años.'
where id = 'cerro-rico';

update public.analogs set
  secondary_categories = array['operational'],
  breaking_point = 'Comparte procesos de evaporación, pero bajo la presión, la gravedad y el clima de la Tierra, con lluvias que inundan la superficie cada año. Aureum Chaos e Icaria Planum se formaron hace miles de millones de años y hoy no tienen agua.'
where id = 'coipasa';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Reproduce aislamiento, frío y oscuridad, pero la tripulación respira aire, vive con gravedad terrestre y puede ser evacuada. No hay vacío, regolito ni la radiación del polo sur lunar.'
where id = 'concordia';

update public.analogs set
  secondary_categories = array['geomorphological'],
  breaking_point = 'Sus glaciares pierden hielo derritiéndose, con agua líquida. En Planum Boreum el hielo se pierde sobre todo por sublimación (pasa directo a gas), a una presión y una temperatura mucho menores.'
where id = 'cordillera-real';

update public.analogs set
  secondary_categories = array['geomorphological'],
  breaking_point = 'Su frío y su aridez son moderados frente a Marte, y conserva atmósfera y vida. Medusae Fossae es un depósito fino y blando que el viento erosiona desde hace millones de años. Todavía no tiene estudios microbiológicos.'
where id = 'desierto-dali';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Es un sistema hidrotermal activo, con agua hirviendo a presión terrestre. Home Plate es un depósito antiguo y apagado. La sílice se parece, pero la vida actual de El Tatio complica distinguir biofirmas antiguas.'
where id = 'el-tatio';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Su hielo se renueva con nieve y en verano la temperatura supera los 0 °C. Los glaciares de Deuteronilus Mensae son restos de climas pasados, siempre bajo cero y con 0,38 veces la gravedad terrestre.'
where id = 'glaciares-roca';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Lo excavó un río. Valles Marineris se abrió por fallas tectónicas y es unas 9 veces más largo y unas 4 veces más profundo. Se parecen las paredes en capas, no el origen.'
where id = 'grand-canyon';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Es corteza antigua meteorizada por un clima tropical, con lluvia, vegetación y suelos con vida. Mawrth Vallis se alteró con agua hace miles de millones de años, sin vida conocida, y conserva cráteres que el escudo no tiene.'
where id = 'guapore';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Mide unos 23 km y lo erosionaron glaciares y agua. Tycho mide unos 85 km, es joven y conserva sus rayos de eyecta porque en la Luna no hay aire ni agua que los borren.'
where id = 'haughton';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Permite ensayar vehículos y procedimientos, pero con aire respirable, gravedad terrestre y apoyo cercano. En Utopia Planitia hacen falta trajes presurizados, hay demora en las comunicaciones y la gravedad es 0,38 veces la terrestre.'
where id = 'haughton-hmp';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Estudia el aislamiento y el trabajo en equipo, pero la tripulación sabe que puede salir y respira aire. No reproduce la gravedad, la radiación ni el riesgo real de una misión.'
where id = 'hi-seas';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Sus domos e ignimbritas son volcanismo andino rico en sílice. Olympus Mons es un volcán en escudo de basalto fluido, de unos 22 km de alto y 600 km de ancho. Se parece el tipo de depósito, no el volcán.'
where id = 'intersalar';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Su erosión combina viento, agua y heladas nocturnas. En Medusae Fossae el viento actúa casi solo, durante millones de años, sobre un material mucho más blando.'
where id = 'italia-perdida';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Su origen por impacto no está confirmado y está cubierta por selva y sedimentos húmedos. Los cráteres fantasma de Utopia Planitia están enterrados en un clima seco. Si no fuera un impacto, la analogía se cae.'
where id = 'iturralde';

update public.analogs set
  secondary_categories = array['geomorphological'],
  breaking_point = 'Es un volcán activo, con agua y aire que alteran sus basaltos rápido. Los mares lunares son basaltos de hace más de 3.000 millones de años, sin agua, y Olympus Mons es mucho más alto y ancho.'
where id = 'kilauea';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Es un sistema hidrotermal activo, con microbios vivos. En Home Plate solo queda el depósito mineral, sin evidencia de vida. Se compara la química del depósito, no un ambiente habitado.'
where id = 'la-salsa';

update public.analogs set
  secondary_categories = array['mineralogical'],
  breaking_point = 'Se secó en pocas décadas por sequía y uso humano del agua. Jezero se secó hace más de 3.000 millones de años por un cambio del clima de todo el planeta. Se observan los depósitos que deja, no el proceso marciano.'
where id = 'lago-poopo';

update public.analogs set
  secondary_categories = array['mineralogical'],
  breaking_point = 'Registra los cambios de nivel de un lago de hace unos 15.000 años, en clima terrestre. Aureum Chaos es terreno hundido por la salida de agua del subsuelo: un proceso distinto y mucho más antiguo.'
where id = 'lago-tauca';

update public.analogs set
  secondary_categories = array['mineralogical'],
  breaking_point = 'Es agua termal estable, con vida actual, a presión terrestre. Home Plate fue un sistema hidrotermal hace miles de millones de años y hoy no tiene agua ni vida conocida.'
where id = 'laguna-blanca-termal';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'El bórax permite formular preguntas sobre el boro, pero no prueba que los minerales de Gale sean iguales. Además es un lago vivo, con algas y flamencos, no un depósito antiguo convertido en roca.'
where id = 'laguna-colorada';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Sus microbialitos los construyó vida que sí existe; en Jezero todavía no se ha confirmado vida. Registra unos 7.000 años, frente a los miles de millones de Marte.'
where id = 'laguna-verde';

update public.analogs set
  secondary_categories = array['geomorphological'],
  breaking_point = 'Entrena la mirada geológica en lava y tubos volcánicos, pero con aire, gravedad terrestre y erosión por agua. Se cree que los tubos de lava lunares, como los de Marius Hills, serían mucho más grandes por la baja gravedad.'
where id = 'lanzarote-pangaea';

update public.analogs set
  secondary_categories = array['mineralogical'],
  breaking_point = 'Tiene UV muy alto y frío, pero agua líquida estable, oxígeno y una presión mucho mayor. Representa lagos antiguos de Marte, no el Marte actual.'
where id = 'licancabur';

update public.analogs set
  secondary_categories = array['geomorphological'],
  breaking_point = 'Es de los lugares más parecidos en frío y sequedad, pero en verano hay algo de agua líquida y la presión del aire es más de cien veces la de Marte. En Shackleton, además, no hay atmósfera en absoluto.'
where id = 'mcmurdo';

update public.analogs set
  secondary_categories = array['geomorphological'],
  breaking_point = 'Simula rutinas de misión con trajes que no están presurizados y con salida posible. No reproduce la baja presión, la radiación ni la demora real de las comunicaciones.'
where id = 'mdrs';

update public.analogs set
  secondary_categories = array['operational'],
  breaking_point = 'Mide 1,2 km y tiene unos 50.000 años. Tycho mide unos 85 km, tiene pico central y rayos de eyecta que la erosión de la Tierra borraría.'
where id = 'meteor-crater';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Es un estratovolcán andino de lava viscosa. Olympus Mons es un enorme escudo de basalto fluido. Lo que se parece es la poca erosión, no la forma ni el tamaño.'
where id = 'ollague';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Tiene agua termal y vida actual que siguen formando carbonatos. Los carbonatos de Jezero son de hace miles de millones de años y su origen biológico no está demostrado.'
where id = 'pastos-grandes';

update public.analogs set
  secondary_categories = array['geomorphological'],
  breaking_point = 'Su suelo se congela de noche y se descongela de día por encima de 0 °C. El hielo de Utopia Planitia está casi siempre congelado, muy bajo cero y con muy poca presión.'
where id = 'permafrost-occidental';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Su acidez se mantiene por agua corriente, microbios que oxidan el hierro y minería antigua. En Meridiani el agua ácida desapareció hace miles de millones de años.'
where id = 'rio-tinto';

update public.analogs set
  secondary_categories = array['geomorphological', 'environmental'],
  breaking_point = 'Pone a prueba baterías y pendientes con frío y altura, pero no con el frío extremo ni la presión de Marte. No todos sus materiales son basálticos como los de Olympus Mons.'
where id = 'sajama';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Es un archivo climático de miles de años, formado por nieve que también se derrite. Las capas de Planum Boreum mezclan hielo y polvo durante millones de años, al ritmo de los cambios de inclinación del eje de Marte.'
where id = 'sajama-hielo';

update public.analogs set
  secondary_categories = array['mineralogical'],
  breaking_point = 'Sus capas registran decenas de miles de años de clima terrestre. Las del Monte Sharp acumulan muchísimo más tiempo y se formaron en un Marte con agua que ya no existe.'
where id = 'salares-capas';

update public.analogs set
  secondary_categories = array['geomorphological'],
  breaking_point = 'Es un lago activo, con agua y vida que siguen formando carbonatos. El lago de Jezero desapareció hace más de 3.000 millones de años.'
where id = 'salda';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'El viento esculpe sus rocas con ayuda del hielo y del agua ocasional. En Marte el aire es más de cien veces más tenue y el viento necesita mucha más velocidad para mover la arena.'
where id = 'siloli';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Tiene alteración ácida y UV alto, pero con agua y gases volcánicos activos a presión terrestre. Home Plate es un depósito apagado y muy antiguo.'
where id = 'sol-de-manana';

update public.analogs set
  secondary_categories = array['geomorphological', 'environmental'],
  breaking_point = 'Prueba suspensión y navegación sin GPS, pero con la gravedad, el aire y los suelos de la Tierra. El regolito marciano tiene otro tamaño de grano y otra cohesión.'
where id = 'sud-lipez';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Sus dunas se mueven con el viento en aire denso. En Medusae Fossae el viento sopla en un aire mucho más tenue y el material es más fino y blando.'
where id = 'tajzara';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Su colapso, de hace unos 12.000 años, ocurrió en un volcán andino pequeño. Los grandes deslizamientos de Valles Marineris y los flancos de Olympus Mons son de una escala mucho mayor.'
where id = 'tata-sabaya';

update public.analogs set
  secondary_categories = array['geomorphological'],
  breaking_point = 'Sirve para entrenar la lectura de capas, pero su cañón es fluvial y de unos 300 m. Valles Marineris es tectónico y llega a 7 km de profundidad.'
where id = 'torotoro';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Es una cueva de caliza disuelta por agua, no un tubo de lava. Sirve para practicar navegación y comunicaciones bajo tierra, no para estudiar la geología de Marius Hills.'
where id = 'umajalanta';

update public.analogs set
  secondary_categories = array['environmental'],
  breaking_point = 'Se inunda cada año con agua de lluvia a presión terrestre. Aureum Chaos es terreno hundido hace miles de millones de años. No se le atribuyen percloratos sin análisis local.'
where id = 'uyuni';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'La comparación es entre cloruros formados por evaporación. Uyuni recibe lluvia y tiene vida microbiana; Icaria Planum lleva miles de millones de años seco y helado.'
where id = 'uyuni-icaria';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Su superficie es plana y firme por sectores, a diferencia del terreno de Meridiani, con ondulaciones de arena y esférulas. Además, la costra puede ocultar salmuera o zonas blandas.'
where id = 'uyuni-navegacion';

update public.analogs set
  secondary_categories = '{}',
  breaking_point = 'Es un contraejemplo: sus polígonos vienen de la convección de la salmuera, no del hielo. Sirve para no confundir causas, no para representar los polígonos de hielo de Marte.'
where id = 'uyuni-poligonos';

update public.analogs set
  secondary_categories = array['mineralogical'],
  breaking_point = 'Sus salmueras son abundantes, estables y a temperatura terrestre. Las salmueras marcianas, si existen, serían escasas, temporales y muy frías.'
where id = 'uyuni-salmueras';

update public.analogs set
  secondary_categories = array['geomorphological'],
  breaking_point = 'Sirve para practicar mapeo 3D, pero su relieve lo formó la lluvia sobre arcillas blandas. Gale no tiene lluvia hoy y su relieve es mucho más antiguo.'
where id = 'valle-de-la-luna';
