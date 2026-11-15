-- =====================================================================
-- 07 · FICHA DE CADA ZONA Y ZONAS NUEVAS                  Dueño: Santiago
-- =====================================================================
-- IDs reservados para coordinar las relaciones de 09_analogos_nuevos.sql:
--   moon-copernicus, moon-aristarchus, moon-hadley-rille,
--   moon-south-pole-aitken, mars-elysium-planitia, mars-nili-fossae,
--   mars-eberswalde.
-- Columnas nuevas de zones (supabase/migrations/20261116000000_profundizacion.sql):
--
--   geology      qué es y cómo se formó
--   environment  condiciones: temperatura, radiación, luz, polvo (con sus límites: medias vs extremos)
--   exploration  misiones que la observaron o visitaron, y su estado
--   importance   por qué interesa a la ciencia o a la exploración
--   sources      arreglo de enlaces: array['https://...', 'https://...']
--
-- La columna description (ya existente) queda como resumen de 1–2 frases.
--
-- Reglas de contenido (README y CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md, sección 12):
--   * Nada sin fuente real. Si no hay fuente, deja source en null y dilo en el texto.
--   * Lenguaje sencillo: lo lee un estudiante, no un especialista.
--   * Comillas simples dentro del texto se escriben dobles: 'no ''simula'' Marte'.
-- Después de editar: bash supabase/seed/exportar-json.sh  (regenera src/data/*.json)
--
-- PARTE A · Completar las zonas existentes (update). Ejemplo de formato:
--
-- update public.zones set
--   geology     = '...',
--   environment = '...',
--   exploration = '...',
--   importance  = '...',
--   sources     = array['https://...']
-- where id = 'mars-jezero';
--
-- PARTE B · Zonas nuevas (insert), sobre todo de la Luna. Primero anuncia los ids en el grupo:
-- Miguel los necesita para relacionar sus análogos nuevos (09 se carga después de 07).
--   * id: 'moon-…' o 'mars-…'; geometry: GeoJSON Polygon en [lon, lat], lon entre -180 y 180.
--   * Verifica las coordenadas (por ejemplo en Wikipedia) antes de dibujar el polígono.
--
-- insert into public.zones (id, body_id, name, zone_type, description, geometry,
--                           geology, environment, exploration, importance, sources) values
--   ('moon-ejemplo', 'moon', 'Nombre', 'Tipo de zona', 'Resumen corto.',
--    '{"type":"Polygon","coordinates":[[[lon1,lat1],[lon2,lat1],[lon2,lat2],[lon1,lat2],[lon1,lat1]]]}',
--    '...', '...', '...', '...', array['https://...'])
-- on conflict (id) do update set
--   name = excluded.name, zone_type = excluded.zone_type, description = excluded.description,
--   geometry = excluded.geometry, geology = excluded.geology, environment = excluded.environment,
--   exploration = excluded.exploration, importance = excluded.importance, sources = excluded.sources;
--
-- Y relaciona cada zona nueva con análogos que ya existen:
-- insert into public.zone_analogs (zone_id, analog_id) values ('moon-ejemplo', 'meteor-crater')
-- on conflict do nothing;
--
-- Checklist de zonas existentes (17):
--   [x] moon-marius-hills
--   [x] moon-shackleton
--   [x] moon-tranquillitatis
--   [x] moon-tycho
--   [x] mars-aureum-chaos
--   [x] mars-deuteronilus-mensae
--   [x] mars-gale
--   [x] mars-gusev-home-plate
--   [x] mars-icaria-planum
--   [x] mars-jezero
--   [x] mars-mawrth-vallis
--   [x] mars-medusae-fossae
--   [x] mars-meridiani
--   [x] mars-olympus-mons
--   [x] mars-planum-boreum
--   [x] mars-utopia-planitia
--   [x] mars-valles-marineris

-- =====================================================================
-- PARTE A · Fichas de las 17 zonas existentes
-- Fuentes consultadas el 14 de noviembre de 2026.
-- Las condiciones actuales y las huellas de ambientes antiguos se distinguen
-- en cada ficha. No se asigna una temperatura única a regiones extensas.
-- =====================================================================

update public.zones set
  geology = 'Campo volcánico con domos, conos y canales sinuosos en Oceanus Procellarum. El pozo de Marius Hills corta varias capas de lava y deja ver una cavidad bajo uno de sus bordes. Esa observación apoya la presencia de espacios subterráneos, pero no determina la extensión de un tubo completo.',
  environment = 'La superficie está cubierta de regolito y expuesta al vacío, al Sol y a cambios térmicos entre el día y la noche lunar. Las paredes del pozo producen sombras locales. Las imágenes de una entrada no bastan para conocer la temperatura, la estabilidad o la protección radiativa de toda una cavidad.',
  exploration = 'La misión japonesa SELENE/Kaguya identificó el pozo en imágenes orbitales. La cámara LROC de Lunar Reconnaissance Orbiter lo observó después con más detalle y desde un ángulo que permitió ver parte del espacio bajo el borde. El interior completo sigue siendo una cuestión de investigación.',
  importance = 'Permite estudiar cómo se acumularon las coladas de lava y cómo se forman las cavidades volcánicas. También ayuda a definir qué tendría que medir un robot antes de evaluar una cueva como posible lugar de trabajo o refugio.',
  sources = array[
    'https://www.lroc.im-ldi.com/images/202',
    'https://lroc.im-ldi.com/images/286',
    'https://science.nasa.gov/moon/facts/'
  ]
where id = 'moon-marius-hills';

update public.zones set
  geology = 'Cráter de impacto situado en el polo sur lunar. Su borde elevado y su fondo profundo generan condiciones de iluminación muy distintas a poca distancia. El relieve permite conservar regiones que el Sol no ilumina directamente.',
  environment = 'El Sol se mantiene cerca del horizonte. Algunos puntos altos del borde reciben iluminación prolongada, mientras que gran parte del interior permanece en sombra y muy frío. Las trampas frías podrían conservar hielo y otros volátiles; su cantidad y accesibilidad deben comprobarse en cada lugar.',
  exploration = 'LRO ha estudiado su forma, iluminación y señales de radar con instrumentos como LOLA y Mini-RF. ShadowCam, a bordo del orbitador coreano Danuri, obtuvo imágenes de su interior oscuro. Estas fuentes describen observaciones orbitales del cráter.',
  importance = 'Ayuda a investigar el almacenamiento de agua y otros volátiles en zonas frías, junto con las dificultades de energía, navegación y control térmico de la exploración polar. La iluminación prolongada de ciertos puntos no garantiza energía continua en cualquier sector del borde.',
  sources = array[
    'https://science.nasa.gov/resource/shackleton-craters-illuminated-rim-shadowed-interior/',
    'https://science.nasa.gov/image-detail/faces-of-shackleton/',
    'https://www.nasa.gov/blogs/missions/2023/02/09/nasas-shadowcam-images-permanently-shadowed-regions-from-lunar-orbit/'
  ]
where id = 'moon-shackleton';

update public.zones set
  geology = 'Llanura oscura formada por antiguas coladas de lava basáltica. Impactos posteriores fragmentaron las rocas y produjeron el regolito superficial. Las muestras del Apolo 11 permiten estudiar directamente la composición y la historia de estos basaltos.',
  environment = 'Es una superficie de baja latitud con alternancia de día y noche lunar. El regolito, los bloques y los pequeños cráteres influyen en el desplazamiento. La exosfera lunar es demasiado tenue para ofrecer una protección comparable a la atmósfera terrestre.',
  exploration = 'El Apolo 11 alunizó en el sector suroeste de Mare Tranquillitatis en julio de 1969. Armstrong y Aldrin realizaron observaciones y recogieron muestras que regresaron a la Tierra. Es un sitio con exploración humana histórica y material disponible para estudios de laboratorio.',
  importance = 'Relaciona la observación orbital con rocas de origen conocido y permite reconstruir episodios de volcanismo lunar. También conserva la experiencia del primer alunizaje tripulado para estudiar operaciones sobre llanuras de basalto y regolito.',
  sources = array[
    'https://nssdc.gsfc.nasa.gov/planetary/lunar/apollo11info.html',
    'https://ares.jsc.nasa.gov/astromaterials3d/sample-catalog.htm?origin=A11',
    'https://science.nasa.gov/moon/facts/'
  ]
where id = 'moon-tranquillitatis';

update public.zones set
  geology = 'Cráter de impacto complejo con paredes escalonadas, un pico central y depósitos de material fundido por el choque. Sus rayos brillantes son material expulsado durante el impacto. La forma relativamente bien conservada permite reconocer distintas partes del proceso de formación.',
  environment = 'Las paredes y el pico central generan pendientes fuertes, bloques y sombras que cambian con la iluminación. El polvo y el regolito cubren parte de los depósitos. La exposición solar y las bajas presiones propias de la Luna condicionan cualquier operación de superficie.',
  exploration = 'LRO ha fotografiado el pico central, sus grandes bloques y depósitos de impacto, incluso con vistas oblicuas. La ficha se apoya en ese estudio orbital del relieve y de las texturas. Su aspecto joven se interpreta en comparación con cráteres lunares más erosionados por impactos posteriores.',
  importance = 'Sirve para investigar la excavación de rocas, la formación de picos centrales y la distribución de material expulsado. Los cráteres terrestres permiten comparar procesos concretos, con diferencias importantes de escala, gravedad y erosión.',
  sources = array[
    'https://science.nasa.gov/resource/tycho-craters-central-peak-on-the-moon/',
    'https://science.nasa.gov/moon/lunar-craters/',
    'https://science.nasa.gov/moon/facts/'
  ]
where id = 'moon-tycho';

update public.zones set
  geology = 'Región de bloques, mesetas y depresiones que forman un terreno caótico. Una interpretación relaciona su hundimiento con la pérdida de soporte del subsuelo al movilizarse agua o hielo. Algunos afloramientos claros contienen minerales arcillosos detectados desde órbita.',
  environment = 'Hoy es un paisaje seco con suelo irregular y acumulaciones de arena. El viento puede modificar los depósitos superficiales. Las arcillas registran interacción antigua entre agua y roca; no indican por sí solas agua líquida presente en el terreno.',
  exploration = 'La cámara HRSC y el instrumento OMEGA de Mars Express estudiaron el relieve y su mineralogía. Las imágenes de HiRISE, en Mars Reconnaissance Orbiter, muestran afloramientos y formas pequeñas con más detalle. La información de esta ficha procede de observación orbital.',
  importance = 'Ayuda a reconstruir episodios de colapso y circulación de agua en el pasado. La comparación con cuencas salinas terrestres se centra en depósitos y procesos geoquímicos concretos, sin convertir un salar entero en una réplica del terreno caótico.',
  sources = array[
    'https://www.esa.int/Science_Exploration/Space_Science/Mars_Express/The_mesas_of_Aureum_Chaos',
    'https://science.nasa.gov/photojournal/light-toned-outcrop-in-aureum-chaos/'
  ]
where id = 'mars-aureum-chaos';

update public.zones set
  geology = 'Región de mesetas y valles en la transición entre las tierras altas y las llanuras del norte. Los depósitos lobulados al pie de algunas laderas contienen abundante hielo de agua bajo una cubierta de rocas y polvo. Su forma y estructura son compatibles con glaciares cubiertos de detritos.',
  environment = 'El frío favorece la conservación del hielo enterrado, mientras la cubierta de detritos limita su pérdida por sublimación. La cantidad de hielo y el espesor de la cubierta varían entre depósitos. Un aspecto liso o lobulado no basta para calcular el hielo de cada sector.',
  exploration = 'El radar SHARAD de Mars Reconnaissance Orbiter detectó depósitos de hielo en la región. Mars Express aportó imágenes del relieve y de las huellas de actividad glaciar. Son resultados orbitales, sin extracción de muestras de estos glaciares.',
  importance = 'Permite investigar cómo cambió la distribución del hielo con el clima y cómo se conserva fuera de los polos. Los glaciares de roca andinos ofrecen comparaciones de forma y cobertura, con procesos y condiciones terrestres que deben evaluarse por separado.',
  sources = array[
    'https://science.nasa.gov/resource/glacial-ice-deposits-in-mid-latitudes-of-mars/',
    'https://www.esa.int/Science_Exploration/Space_Science/Mars_Express/Fractured_ice_sheets_on_Mars'
  ]
where id = 'mars-deuteronilus-mensae';

update public.zones set
  geology = 'Cráter con un monte central, Aeolis Mons o monte Sharp, formado por una extensa sucesión de capas. Los sedimentos registran antiguos lagos, aportes de ríos y periodos secos. La erosión dejó expuestas rocas con arcillas, sulfatos y otras señales de cambios ambientales.',
  environment = 'El paisaje actual es seco, frío y sometido al transporte de polvo y arena. Las pendientes y la iluminación cambian entre el fondo del cráter y el monte. Las mediciones de un punto, una hora o una estación no representan toda la climatología de Gale.',
  exploration = 'Curiosity aterrizó en Gale en 2012 e inició una exploración de superficie con imágenes, análisis de rocas y mediciones ambientales. Sus recorridos por las capas del monte Sharp permiten contrastar las interpretaciones hechas desde órbita con observaciones del terreno.',
  importance = 'Es un archivo de la transición entre ambientes con agua y etapas más secas. El interés en habitabilidad consiste en saber si hubo condiciones adecuadas para microorganismos y si sus posibles señales podrían conservarse en las rocas.',
  sources = array[
    'https://science.nasa.gov/resource/a-guide-to-gale-crater/',
    'https://science.nasa.gov/resource/sedimentation-and-erosion-in-gale-crater-mars/',
    'https://science.nasa.gov/resource/now-and-long-ago-at-gale-crater-mars/'
  ]
where id = 'mars-gale';

update public.zones set
  geology = 'Home Plate es una pequeña meseta de rocas volcánicas estratificadas en las Columbia Hills del cráter Gusev. Cerca de ella, Spirit encontró materiales muy ricos en sílice. Las observaciones se interpretan como evidencia de un antiguo sistema hidrotermal, con fuentes calientes o vapor.',
  environment = 'El entorno actual presenta polvo, arena y rocas expuestas bajo una atmósfera tenue. Las señales hidrotermales describen condiciones del pasado. La sílice no demuestra que hoy existan fuentes calientes o agua líquida en este lugar.',
  exploration = 'Spirit aterrizó en Gusev en 2004 y exploró las Columbia Hills y Home Plate. Una rueda que arrastraba dejó al descubierto el material rico en sílice investigado en 2007. La misión está finalizada y sus datos siguen disponibles para investigación.',
  importance = 'Los depósitos hidrotermales permiten estudiar cómo el agua caliente modifica las rocas y qué ambientes podrían conservar señales de vida antigua. La comparación con El Tatio y otros sistemas termales se limita a materiales y procesos identificables.',
  sources = array[
    'https://science.nasa.gov/mission/mer-spirit/',
    'https://science.nasa.gov/resource/rovers-wheel-churns-up-bright-martian-soil/',
    'https://www.usgs.gov/publications/characteristics-distribution-origin-and-significance-opaline-silica-observed-spirit'
  ]
where id = 'mars-gusev-home-plate';

update public.zones set
  geology = 'Llanura del hemisferio sur con afloramientos interpretados como depósitos de cloruros. Una explicación los relaciona con la concentración de sales al desaparecer agua salada. El trabajo presentado en EPSC 2024 cartografía estos materiales y examina una posible comparación con Uyuni.',
  environment = 'Los depósitos se observan en un entorno marciano actualmente seco. El interés está en el registro mineral de antiguos episodios de agua, no en la presencia demostrada de un salar inundado hoy. Su parecido con Uyuni no implica la misma presión, radiación ni composición completa del suelo.',
  exploration = 'La cartografía publicada en EPSC 2024 utiliza información orbital, incluyendo datos de THEMIS en Mars Odyssey y otras imágenes de la superficie. El estudio es una contribución de congreso sobre depósitos y su comparación terrestre, no un análisis de muestras recogidas en Icaria.',
  importance = 'Permite investigar las últimas etapas de cuerpos de agua y la preservación de sales en ambientes que se secaron. La relación con Uyuni plantea preguntas comprobables sobre evaporación y minerales; no atribuye percloratos al salar boliviano.',
  sources = array[
    'https://meetingorganizer.copernicus.org/EPSC2024/EPSC2024-483.html',
    'https://science.nasa.gov/earth/earth-observatory/bolivian-salt-flats-151813/'
  ]
where id = 'mars-icaria-planum';

update public.zones set
  geology = 'Cráter que albergó un antiguo lago alimentado por ríos. En su borde se conserva un delta, donde el agua depositó sedimentos. La región contiene rocas volcánicas, materiales sedimentarios y minerales como carbonatos que ayudan a reconstruir distintos episodios de su historia.',
  environment = 'El lago antiguo está seco y sus depósitos quedan expuestos a erosión, polvo y radiación. El ambiente cambia con la hora y la estación, y las rocas de distintos sectores conservan registros diferentes. El antiguo ambiente acuoso no representa las condiciones actuales de toda la zona.',
  exploration = 'Perseverance aterrizó en Jezero en febrero de 2021. La misión analiza rocas y recoge muestras selladas, relacionando observaciones de superficie con mapas orbitales. Recoger una muestra no equivale a que ya haya sido transportada a un laboratorio terrestre.',
  importance = 'Los sedimentos y minerales permiten investigar la duración del lago y la posible conservación de señales de vida antigua. Estudiar habitabilidad o buscar biofirmas no constituye una confirmación de vida en Marte.',
  sources = array[
    'https://science.nasa.gov/mission/mars-2020-perseverance/',
    'https://science.nasa.gov/resource/detailed-panorama-of-mars-jezero-crater-delta/',
    'https://science.nasa.gov/earth/earth-observatory/jez-like-mars-147041/'
  ]
where id = 'mars-jezero';

update public.zones set
  geology = 'Valle antiguo junto al límite entre las tierras altas del sur y las llanuras del norte. Sus afloramientos claros contienen capas ricas en arcillas de distinta composición. Esos minerales registran procesos de alteración de roca por agua en el pasado.',
  environment = 'Hoy se observan superficies erosionadas, cráteres y mantos de material más oscuro. El polvo puede ocultar parte de las capas, por lo que la mineralogía detectada depende de los afloramientos expuestos. Las arcillas son un registro de ambientes antiguos, no una medición de humedad actual.',
  exploration = 'Mars Express ha estudiado el relieve y la distribución de minerales. Otros orbitadores también identificaron arcillas y capas, y la región fue evaluada como posible lugar de aterrizaje de Curiosity. La ficha describe resultados orbitales y una candidatura histórica, no una visita de ese rover.',
  importance = 'La sucesión de arcillas permite comparar diferentes episodios de agua y evaluar la conservación de posibles biofirmas. Su interés está en reconstruir ambientes habitables y reconocer minerales sin confundirlos con una prueba de vida.',
  sources = array[
    'https://www.esa.int/Science_Exploration/Space_Science/Mars_Express/The_clays_of_Mawrth_Vallis',
    'https://science.nasa.gov/resource/mawrth-vallis-3-d/'
  ]
where id = 'mars-mawrth-vallis';

update public.zones set
  geology = 'Formación extensa de depósitos blandos modelados por el viento, con crestas alargadas llamadas yardangs. Se han propuesto materiales volcánicos y acumulaciones de polvo para explicar parte de su origen. Un análisis de radar publicado en 2024 interpreta señales del subsuelo como capas ricas en hielo bajo material seco.',
  environment = 'La superficie es árida y el viento erosiona y redistribuye partículas. Una interpretación de hielo profundo no implica hielo expuesto ni agua líquida superficial. El polvo y la cubierta seca condicionan lo que puede verse en imágenes y lo que solo puede inferirse con radar.',
  exploration = 'Mars Express combina imágenes de la superficie con observaciones de su radar MARSIS. Las nuevas interpretaciones de los ecos se comparan con los depósitos polares y con modelos de materiales. La composición profunda se infiere a distancia y requiere contrastar esas interpretaciones.',
  importance = 'Permite estudiar la erosión eólica, el origen de grandes depósitos de polvo y la posible conservación de hielo cerca del ecuador. Relacionar imágenes y radar ayuda a evitar que el aspecto de la superficie se confunda con la composición del subsuelo.',
  sources = array[
    'https://www.esa.int/ESA_Multimedia/Images/2024/01/Location_of_Mars_s_Medusae_Fossae_Formation',
    'https://www.esa.int/Science_Exploration/Space_Science/Mars_Express/Buried_water_ice_at_Mars_s_equator'
  ]
where id = 'mars-medusae-fossae';

update public.zones set
  geology = 'Llanura con areniscas ricas en sulfatos y pequeñas concreciones de hematita. Las rocas conservan señales de agua y de procesos químicos antiguos, incluidos ambientes ácidos. La superficie también fue modificada por arena transportada por el viento.',
  environment = 'El paisaje actual es seco, con dunas, ondulaciones y afloramientos rocosos. El polvo atmosférico puede reducir mucho la energía solar disponible: la gran tormenta de 2018 interrumpió las comunicaciones de Opportunity. Las sales de las rocas no demuestran agua líquida estable en la superficie actual.',
  exploration = 'Mars Global Surveyor detectó hematita desde órbita, lo que ayudó a seleccionar el lugar de aterrizaje. Opportunity llegó en 2004 y estudió sus rocas durante años. La última señal se recibió en 2018 y NASA declaró terminada la misión en febrero de 2019.',
  importance = 'Es un caso de referencia para unir minerales observados desde órbita con análisis de superficie. Permite estudiar cómo el agua, la evaporación y la química del hierro dejaron huellas en un ambiente que después se volvió más seco.',
  sources = array[
    'https://science.nasa.gov/resource/meridiani-planum-2/',
    'https://astrobiology.nasa.gov/missions/mer/',
    'https://ares.jsc.nasa.gov/missions/mer/'
  ]
where id = 'mars-meridiani';

update public.zones set
  geology = 'Gran volcán en escudo construido por la acumulación de coladas de lava. Su cima tiene calderas y sus flancos terminan en escarpes con depósitos de deslizamiento. Compararlo con volcanes terrestres ayuda a estudiar procesos, aunque sus dimensiones son mucho mayores.',
  environment = 'La gran diferencia de altitud entre las llanuras, las laderas y la cima influye en presión y temperatura. Las pendientes y escarpes condicionan la movilidad y la iluminación. No corresponde asignar al volcán entero una temperatura o una presión medidas en otra región de Marte.',
  exploration = 'Mariner 9 permitió reconocer el gran edificio volcánico en 1971. Mars Express ha observado sus flancos, escarpes y depósitos con imágenes y modelos del relieve. La cartografía geológica combina datos de distintas misiones orbitales.',
  importance = 'Ayuda a reconstruir la historia del volcanismo de Tharsis y los colapsos de grandes edificios volcánicos. Las avalanchas terrestres y las coladas ofrecen analogías parciales que deben distinguir forma, material y escala.',
  sources = array[
    'https://pubs.usgs.gov/publication/i2327',
    'https://www.esa.int/Science_Exploration/Space_Science/Mars_Express/Escarpment_and_landslides_of_Olympus_Mons',
    'https://www.esa.int/Science_Exploration/Space_Science/Mars_Express/Landslides_at_the_foot_of_Olympus_Mons'
  ]
where id = 'mars-olympus-mons';

update public.zones set
  geology = 'Casquete del polo norte formado principalmente por capas de hielo de agua y polvo. Sus escarpes y valles dejan ver la sucesión de materiales. Las diferencias entre capas registran cambios en el depósito de hielo y partículas a lo largo del tiempo.',
  environment = 'La iluminación cambia de forma marcada entre las estaciones polares. En invierno se añade escarcha estacional de dióxido de carbono, mientras el casquete de agua persiste. La sublimación, el viento y el depósito de polvo contribuyen a modificar las superficies y los bordes.',
  exploration = 'Las imágenes de Mars Express y de HiRISE en Mars Reconnaissance Orbiter muestran las capas y sus contactos. Los datos permiten estudiar la forma de los depósitos y comparar unidades entre distintos sectores del polo.',
  importance = 'Es un archivo de cambios climáticos de Marte. Las capas de hielo terrestres ofrecen comparaciones de acumulación y registro ambiental, pero no reproducen el ciclo polar de hielo de dióxido de carbono marciano.',
  sources = array[
    'https://science.nasa.gov/resource/stratigraphy-of-the-north-polar-deposits/',
    'https://www.esa.int/Science_Exploration/Space_Science/Mars_Express/Sand_dunes_meet_stacked_ice_at_Mars_s_north_pole'
  ]
where id = 'mars-planum-boreum';

update public.zones set
  geology = 'Gran llanura del norte que presenta cráteres degradados, superficies poligonales y depresiones festoneadas. En sectores de Utopia, el radar ha identificado depósitos ricos en hielo bajo una cubierta de suelo. Estos resultados corresponden a áreas estudiadas y no prueban la misma cantidad de hielo en toda la llanura.',
  environment = 'El ambiente de estas latitudes puede presentar heladas estacionales, como las fotografiadas por Viking 2. El hielo enterrado se protege en parte por el material que lo cubre. Un polígono superficial puede tener distintos orígenes, por lo que la forma sola no demuestra permafrost.',
  exploration = 'Viking 2 aterrizó en Utopia Planitia en 1976 y realizó observaciones de superficie; su misión está finalizada. Posteriormente, el radar SHARAD de Mars Reconnaissance Orbiter investigó depósitos del subsuelo en otros sectores de la región.',
  importance = 'Permite estudiar la distribución del hielo y cómo cambian los suelos fríos. Comparar imágenes con radar y mediciones de superficie ayuda a distinguir hielo enterrado, heladas temporales y formas parecidas producidas por otros procesos.',
  sources = array[
    'https://science.nasa.gov/mission/viking-2/',
    'https://science.nasa.gov/resource/scalloped-terrain-led-to-finding-of-buried-ice-on-mars/',
    'https://science.nasa.gov/photojournal/ice-on-mars-utopia-planitia-again/'
  ]
where id = 'mars-utopia-planitia';

update public.zones set
  geology = 'Sistema de cañones asociado a fracturas de la corteza y al desarrollo de la región volcánica de Tharsis. El hundimiento, los deslizamientos y la erosión ensancharon y modificaron sus valles. Algunas paredes y depósitos interiores conservan capas que registran distintos episodios geológicos.',
  environment = 'El fuerte desnivel crea paredes empinadas, fondos profundos y sombras muy variables. Arena y polvo se acumulan en sectores de los valles. La geometría local influye en la iluminación y en la temperatura del suelo, sin que un único valor describa todo el sistema.',
  exploration = 'Mars Odyssey produjo mosaicos con THEMIS y Mars Express obtuvo imágenes y modelos del relieve con HRSC. Las observaciones orbitales permiten cartografiar fallas, capas y deslizamientos a diferentes escalas.',
  importance = 'Ayuda a investigar la deformación de la corteza, la evolución de grandes laderas y los depósitos estratificados. Un cañón terrestre de origen fluvial puede servir para observar capas o practicar geología, sin reproducir el origen tectónico de Valles Marineris.',
  sources = array[
    'https://science.nasa.gov/resource/the-grand-canyon-of-mars-valles-marineris/',
    'https://www.esa.int/Science_Exploration/Space_Science/Mars_Express/Melas_Candor_and_Ophir_Chasmas_centre_of_Valles_Marineris'
  ]
where id = 'mars-valles-marineris';

-- =====================================================================
-- PARTE B · Siete zonas nuevas con ficha completa
-- Los rectángulos son áreas aproximadas de selección, no límites geológicos.
-- Aitken representa el sector de Apollo, enteramente al oeste de -140 grados,
-- para conservar Polygon sin cruzar el antimeridiano. Elysium representa el
-- entorno occidental de InSight, no toda la provincia volcánica.
--
-- Puntos de referencia incluidos en los polígonos [lon, lat]:
--   Copernicus [-20, 10]: NASA, Limb of Copernicus Impact Crater.
--   Aristarchus [-47.4, 23.7]: NASA NTRS 20000040479, p. 42.
--   Hadley [3.633, 26.132]: NASA NSSDCA, Apollo Lunar Landings.
--   Apollo/Chang'e-6 [-153.99, -41.64]: ESA, NILS, 2024.
--   InSight [135.6, 4.5]: HiRISE DTM ESP_037262_1845.
--   Nili Fossae [78.2, 21.9]: NASA CRISM, PIA09933.
--   Eberswalde [-33, -24]: NASA, candidatos MSL, 2011 (327 E = -33).
-- =====================================================================

insert into public.zones (
  id, body_id, name, zone_type, description, geometry,
  geology, environment, exploration, importance, sources
) values
  (
    'moon-copernicus', 'moon', 'Cráter Copernicus', 'Cráter de impacto con rayos y picos centrales',
    'Cráter de impacto de la cara visible con paredes escalonadas y extensos rayos de material expulsado.',
    '{"type":"Polygon","coordinates":[[[-22,7.5],[-18,7.5],[-18,11.8],[-22,11.8],[-22,7.5]]]}',
    'Cráter complejo formado por un gran impacto. El choque excavó material, levantó estructuras centrales y expulsó fragmentos que produjeron rayos y cráteres secundarios. Sus paredes muestran el colapso y reajuste del terreno tras la excavación.',
    'Su relieve combina un fondo relativamente bajo con paredes, bloques y pendientes. La iluminación resalta u oculta detalles según el ángulo solar. Como en otras zonas lunares, el regolito y los cambios térmicos condicionan la exploración de superficie.',
    'El Apolo 17 fotografió Copernicus desde órbita en 1972. Las imágenes orbitales y los modelos del relieve permiten estudiar el cráter y relacionarlo con las cadenas de cráteres secundarios de sus alrededores.',
    'Permite comparar cómo se forman cráteres complejos y cómo se distribuye el material expulsado. Meteor Crater y Haughton ofrecen referencias terrestres para partes de estos procesos, con diferencias de tamaño y conservación.',
    array[
      'https://science.nasa.gov/3d-resources/moon-copernicus-crater/',
      'https://science.nasa.gov/resource/copernicus-crater/',
      'https://science.nasa.gov/photojournal/limb-of-copernicus-impact-crater/'
    ]
  ),
  (
    'moon-aristarchus', 'moon', 'Meseta de Aristarchus', 'Meseta volcánica con depósitos piroclásticos y cráter de impacto',
    'Región de Oceanus Procellarum con canales de lava, depósitos de erupciones explosivas y el brillante cráter Aristarchus.',
    '{"type":"Polygon","coordinates":[[[-53,21],[-44,21],[-44,30],[-53,30],[-53,21]]]}',
    'La meseta reúne canales sinuosos, materiales volcánicos y una extensa cubierta de depósitos piroclásticos. El cráter Aristarchus expone y redistribuye materiales de la región. Esta combinación permite comparar erupciones, coladas e impactos dentro de una misma zona.',
    'Las superficies claras y oscuras reflejan cantidades diferentes de luz. El relieve de cráteres y canales produce sombras que cambian con el Sol. Las diferencias de brillo deben analizarse junto con datos espectrales antes de asignarles una composición mineral.',
    'Hubble observó Aristarchus y su entorno en 2005 en luz visible y ultravioleta. Los modelos del relieve y las imágenes permiten estudiar el cráter, Vallis Schroeteri y los depósitos de la meseta desde fuera de la superficie.',
    'Ayuda a investigar la diversidad del volcanismo lunar y la mezcla de materiales por impactos. Los terrenos volcánicos terrestres permiten practicar observación y comparación de procesos, sin garantizar composiciones idénticas.',
    array[
      'https://science.nasa.gov/3d-resources/moon-aristarchus-region/',
      'https://science.nasa.gov/asset/hubble/aristarchus-plateau-on-the-moon/',
      'https://ntrs.nasa.gov/api/citations/20000040479/downloads/20000040479.pdf'
    ]
  ),
  (
    'moon-hadley-rille', 'moon', 'Hadley Rille y entorno del Apolo 15', 'Canal volcánico junto a las montañas Apeninas',
    'Canal sinuoso asociado a antiguas lavas, junto al lugar que exploró la tripulación del Apolo 15 en 1971.',
    '{"type":"Polygon","coordinates":[[[1.5,24.5],[4.8,24.5],[4.8,27.5],[1.5,27.5],[1.5,24.5]]]}',
    'Hadley Rille corta llanuras basálticas cerca del frente de las montañas Apeninas. Se interpreta como un sistema relacionado con el transporte de lava, con posibles etapas de canal y tubo. Las paredes exponen capas útiles para reconstruir las erupciones.',
    'El terreno combina llanuras, bloques, laderas de montaña y el borde de un canal profundo. Las sombras de ese relieve influyen en la visibilidad. La misión de superficie se realizó con iluminación diurna; esa experiencia no caracteriza toda la noche lunar.',
    'El Apolo 15 exploró la región Hadley-Apennine en 1971 con astronautas y un vehículo lunar. Regresó con muestras, fotografías y observaciones geológicas. LRO obtuvo después vistas del entorno y del lugar de aterrizaje.',
    'Permite unir geología observada por personas, muestras de laboratorio y cartografía orbital. Es una referencia para planificar recorridos científicos y estudiar la secuencia de coladas a partir de paredes expuestas.',
    array[
      'https://www.nasa.gov/missions/apollo/apollo-15-mission-details/',
      'https://www.nasa.gov/image-article/soaring-over-lunar-mt-hadley/',
      'https://nssdc.gsfc.nasa.gov/planetary/lunar/apolloland.html',
      'https://ntrs.nasa.gov/api/citations/19860013039/downloads/19860013039.pdf'
    ]
  ),
  (
    'moon-south-pole-aitken', 'moon', 'Cuenca Polo Sur-Aitken, sector de Apollo', 'Sector de una antigua cuenca de impacto de la cara oculta',
    'Sector de la gran cuenca Polo Sur-Aitken que incluye el entorno de Apollo, donde Chang''e-6 recogió muestras en 2024.',
    '{"type":"Polygon","coordinates":[[[-175,-55],[-140,-55],[-140,-30],[-175,-30],[-175,-55]]]}',
    'Polo Sur-Aitken es una de las mayores y más antiguas cuencas de impacto lunares. El choque excavó y redistribuyó materiales y otros impactos y episodios volcánicos modificaron después su interior. El sector representado incluye parte de la cuenca Apollo, dentro de esa estructura mayor.',
    'Este sector de la cara oculta presenta relieve craterizado y alternancia de día y noche lunar. La localización dentro de una cuenca llamada Polo Sur-Aitken no convierte toda su superficie en sombra permanente. La temperatura y la iluminación dependen del lugar y del momento de observación.',
    'LRO y GRAIL aportaron datos sobre el relieve y la estructura de la gran cuenca. Chang''e-6 aterrizó en el sector de Apollo y retornó muestras a la Tierra en junio de 2024. ESA participó con el instrumento NILS y con apoyo de estaciones terrestres.',
    'Las rocas ayudan a reconstruir grandes impactos y la evolución de la cara oculta. Las muestras obtenidas permiten contrastar interpretaciones orbitales, pero no debe asumirse que todo material recogido procede directamente del manto lunar.',
    array[
      'https://science.nasa.gov/moon/lunar-craters/what-is-the-south-pole-aitken-basin/',
      'https://www.esa.int/Science_Exploration/Human_and_Robotic_Exploration/First_detection_of_negative_ions_on_the_Moon',
      'https://www.esa.int/Enabling_Support/Operations/ESA_Ground_Stations/ESA_stations_support_three_Moon_missions_in_2024'
    ]
  ),
  (
    'mars-elysium-planitia', 'mars', 'Elysium Planitia, entorno de InSight', 'Llanura volcánica con mediciones del interior de Marte',
    'Sector occidental de Elysium Planitia alrededor del lugar donde InSight estudió la estructura interna de Marte.',
    '{"type":"Polygon","coordinates":[[[134,3],[138,3],[138,6],[134,6],[134,3]]]}',
    'Llanura de origen volcánico cubierta por regolito y sedimentos superficiales. El entorno de aterrizaje de InSight fue elegido por sus pendientes suaves y por presentar pocos grandes obstáculos. Los impactos y el transporte de partículas modificaron la superficie después de las lavas.',
    'La acumulación de polvo y las variaciones de viento, presión y temperatura afectan a los instrumentos y a la producción de energía solar. InSight registró cambios atmosféricos en su emplazamiento. Esas mediciones son locales y no equivalen a una climatología de toda la provincia de Elysium.',
    'InSight aterrizó en noviembre de 2018 y utilizó un sismómetro para estudiar el interior del planeta. NASA dio por terminada la misión en diciembre de 2022, tras la pérdida de capacidad de generar energía por sus paneles cubiertos de polvo.',
    'Relaciona el terreno superficial con el estudio de corteza, manto y núcleo. También ofrece un caso real para analizar cómo el polvo, la energía disponible y las condiciones del suelo influyen en la duración de una misión.',
    array[
      'https://www.jpl.nasa.gov/news/press_kits/insight/launch/mission/landing-site/',
      'https://www.uahirise.org/dtm/ESP_037262_1845',
      'https://science.nasa.gov/mission/insight/'
    ]
  ),
  (
    'mars-nili-fossae', 'mars', 'Nili Fossae', 'Fracturas con olivino, arcillas y carbonatos',
    'Región fracturada junto a la cuenca Isidis con minerales que registran volcanismo e interacción antigua entre agua y roca.',
    '{"type":"Polygon","coordinates":[[[72,19],[80,19],[80,25],[72,25],[72,19]]]}',
    'Conjunto de fosas tectónicas y afloramientos al noroeste de Isidis. Las observaciones espectrales identifican olivino, arcillas y carbonatos en distintos sectores. Sus relaciones permiten investigar cómo materiales volcánicos fueron modificados por agua y otros procesos.',
    'Las fracturas, laderas y acumulaciones de arena producen superficies muy distintas dentro de la región. Los minerales expuestos registran episodios antiguos y el polvo puede ocultarlos. La detección de carbonatos no demuestra un lago actual ni una misma historia de agua en todos los afloramientos.',
    'Mars Express obtuvo imágenes del relieve y Mars Reconnaissance Orbiter combinó datos de CRISM y HiRISE para relacionar mineralogía y formas pequeñas. Esta ficha se basa en resultados orbitales de sectores concretos de Nili Fossae.',
    'Permite comparar materiales volcánicos poco alterados con minerales producidos por interacción con agua. Los carbonatos terrestres ofrecen una comparación geoquímica parcial, mientras que el origen específico de cada depósito marciano debe investigarse por sus propias evidencias.',
    array[
      'https://www.esa.int/Science_Exploration/Space_Science/Mars_Express/Mars_Express_sees_deep_fractures_on_Mars',
      'https://science.nasa.gov/photojournal/phyllosilicate-and-olivine-around-a-fracture-in-nili-fossae/',
      'https://science.nasa.gov/photojournal/carbonate-olivine-relationship-in-nile-fossae-mars/'
    ]
  ),
  (
    'mars-eberswalde', 'mars', 'Cráter Eberswalde', 'Cráter con un delta fluvial conservado',
    'Cráter que conserva un antiguo delta, con canales ramificados y capas depositadas cuando el agua transportaba sedimentos hacia un lago.',
    '{"type":"Polygon","coordinates":[[[-34.5,-25.5],[-32,-25.5],[-32,-22.5],[-34.5,-22.5],[-34.5,-25.5]]]}',
    'El delta conserva una red de canales distributarios, curvas de antiguos cauces y capas de sedimentos. Parte de los canales quedó elevada respecto al terreno vecino por erosión diferencial. Estas formas respaldan la interpretación de un río que desembocaba en un antiguo cuerpo de agua.',
    'Hoy es un paisaje seco con depósitos expuestos y modificados por erosión. La luz y las sombras sobre las capas cambian con el relieve y con el momento de observación. El delta registra un ambiente acuoso antiguo, no una desembocadura con agua líquida en la actualidad.',
    'Mars Global Surveyor permitió reconocer el delta en imágenes de MOC. Mars Express y HiRISE en Mars Reconnaissance Orbiter aportaron observaciones posteriores. Eberswalde fue finalista para el aterrizaje de Curiosity, pero la misión eligió Gale.',
    'Permite estudiar el transporte de sedimentos y la duración de antiguos lagos. Las capas del delta son de interés para buscar materiales que pudieran conservar señales de vida pasada, si esta hubiera existido.',
    array[
      'https://science.nasa.gov/resource/delta-structure-in-eberswalde-crater/',
      'https://science.nasa.gov/resource/eberswalde-delta-3-d/',
      'https://www.esa.int/Science_Exploration/Space_Science/Mars_Express/Rare_martian_lake_delta_spotted_by_Mars_Express'
    ]
  )
on conflict (id) do update set
  body_id = excluded.body_id,
  name = excluded.name,
  zone_type = excluded.zone_type,
  description = excluded.description,
  geometry = excluded.geometry,
  geology = excluded.geology,
  environment = excluded.environment,
  exploration = excluded.exploration,
  importance = excluded.importance,
  sources = excluded.sources;

-- Relaciones propuestas por procesos o por métodos de trabajo. No implican
-- equivalencia física ni que se hayan realizado campañas en estos lugares.
-- Se conservan los IDs, categorías y niveles de respaldo de los 51 análogos.
insert into public.zone_analogs (zone_id, analog_id) values
  -- Cráteres terrestres para partes de los procesos de impacto.
  ('moon-copernicus', 'meteor-crater'),
  ('moon-copernicus', 'haughton'),
  -- Volcanismo y geología de campo; composiciones y escalas distintas.
  ('moon-aristarchus', 'kilauea'),
  ('moon-aristarchus', 'lanzarote-pangaea'),
  ('moon-hadley-rille', 'kilauea'),
  ('moon-hadley-rille', 'basalt'),
  ('moon-hadley-rille', 'lanzarote-pangaea'),
  -- Haughton compara estructuras de impacto a otra escala; HMP aporta métodos.
  ('moon-south-pole-aitken', 'haughton'),
  ('moon-south-pole-aitken', 'haughton-hmp'),
  ('moon-south-pole-aitken', 'meteor-crater'),
  -- Materiales volcánicos y operación de instrumentos sobre suelo caracterizado.
  ('mars-elysium-planitia', 'kilauea'),
  ('mars-elysium-planitia', 'basalt'),
  ('mars-elysium-planitia', 'sud-lipez'),
  -- Carbonatos y geoquímica acuosa, sin atribuir a los lagos un origen tectónico.
  ('mars-nili-fossae', 'pastos-grandes'),
  ('mars-nili-fossae', 'la-salsa'),
  ('mars-nili-fossae', 'laguna-verde'),
  -- Ambientes lacustres, archivos sedimentarios y lectura de capas.
  ('mars-eberswalde', 'lago-tauca'),
  ('mars-eberswalde', 'salda'),
  ('mars-eberswalde', 'torotoro')
on conflict (zone_id, analog_id) do nothing;
