-- =====================================================================
-- 08 · ENTRENAMIENTOS POSIBLES EN CADA ANÁLOGO           Dueño: Miguel
-- =====================================================================
-- Tabla: analog_trainings (supabase/migrations/20261116000000_profundizacion.sql)
--
--   analog_id     id del análogo
--   position      1, 2, 3… orden dentro del análogo (de 1 a 3 actividades por análogo)
--   audience      astronauts | rovers | suits | habitats | science
--   activity      qué se practica
--   measures      qué se mide para saber si salió bien
--   restrictions  permisos, seguridad o conservación (null si no aplica)
--   source        enlace específico, o null si vale la fuente del análogo
--
-- Base principal para Bolivia: tmp/lectura/F2.txt, secciones 4.1–4.7, 8 y 11.
-- Son actividades POSIBLES o PROPUESTAS: no afirmes que ya se hicieron si la fuente no lo dice.
--
-- Reglas de contenido (README y CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md, sección 12):
--   * Nada sin fuente real. Si no hay fuente, deja source en null y dilo en el texto.
--   * Lenguaje sencillo: lo lee un estudiante, no un especialista.
--   * Comillas simples dentro del texto se escriben dobles: 'no ''simula'' Marte'.
-- Después de editar: bash supabase/seed/exportar-json.sh  (regenera src/data/*.json)
--
-- Ejemplo (formato; los textos hay que comprobarlos antes de usarlos):
--
-- insert into public.analog_trainings (analog_id, position, audience, activity, measures, restrictions, source) values
--   ('sajama', 1, 'rovers',
--    'Arranque de baterías en frío y ascenso por pendientes conocidas.',
--    'Voltaje y tiempo de arranque, patinaje y estabilidad lateral.',
--    'No circular sobre bofedales ni sitios arqueológicos. Evaluación médica de altura obligatoria.',
--    null)
-- on conflict (analog_id, position) do update set
--   audience = excluded.audience, activity = excluded.activity, measures = excluded.measures,
--   restrictions = excluded.restrictions, source = excluded.source;
--
-- Checklist (51 análogos existentes):
--   [x] atacama
--   [x] basalt
--   [x] canapa
--   [x] cerro-rico
--   [x] coipasa
--   [x] concordia
--   [x] cordillera-real
--   [x] desierto-dali
--   [x] el-tatio
--   [x] glaciares-roca
--   [x] grand-canyon
--   [x] guapore
--   [x] haughton
--   [x] haughton-hmp
--   [x] hi-seas
--   [x] intersalar
--   [x] italia-perdida
--   [x] iturralde
--   [x] kilauea
--   [x] lago-poopo
--   [x] lago-tauca
--   [x] laguna-blanca-termal
--   [x] laguna-colorada
--   [x] laguna-verde
--   [x] lanzarote-pangaea
--   [x] la-salsa
--   [x] licancabur
--   [x] mcmurdo
--   [x] mdrs
--   [x] meteor-crater
--   [x] ollague
--   [x] pastos-grandes
--   [x] permafrost-occidental
--   [x] rio-tinto
--   [x] sajama
--   [x] sajama-hielo
--   [x] salares-capas
--   [x] salda
--   [x] siloli
--   [x] sol-de-manana
--   [x] sud-lipez
--   [x] tajzara
--   [x] tata-sabaya
--   [x] torotoro
--   [x] umajalanta
--   [x] uyuni
--   [x] valle-de-la-luna

-- Todas las actividades siguientes son propuestas de ejercicio, no un registro de campañas.
-- F2 = tmp/lectura/F2.txt, secciones 4.1–4.7, 8 y 11 (base de las propuestas bolivianas).
-- F4 = tmp/lectura/F4.txt (contexto del sitio y su nivel de respaldo, sin elevarlo).
-- Un enlace respalda el sitio o el método; no afirma que se haya ejecutado este ejercicio exacto.
-- Cuando falta publicación específica se usa NULL y se explicita en restrictions.
-- Las métricas requieren referencia, instrumentos y condiciones registrados para comparar ensayos.
-- No se usan personas para ensayar límites térmicos, de presión o de radiación.

insert into public.analog_trainings
  (analog_id, position, audience, activity, measures, restrictions, source) values
  ('atacama', 1, 'science',
   'Propuesta: diseñar una búsqueda de señales de vida en un ambiente seco, comparando objetivos minerales con muestras de referencia y blancos de contaminación.',
   'Objetivos documentados, blancos sin contaminación, falsos positivos y concordancia con el análisis de referencia.',
   'Permisos para muestreo y protección de ecosistemas. Trabajar con materiales preparados cuando no se autorice extracción; no equiparar sequedad con esterilidad.',
   'https://science.nasa.gov/solar-system/analog-explorer/'),
  ('basalt', 1, 'astronauts',
   'Propuesta basada en BASALT: seleccionar y documentar muestras volcánicas coordinando al equipo de campo con científicos remotos y una demora de enlace definida.',
   'Objetivos completados, calidad de fotografías y descripciones, tiempo de decisión y mensajes que llegan fuera de la ventana de trabajo.',
   'Introducir demora solo en el canal del ejercicio; mantener comunicación de seguridad inmediata. El precedente no demuestra que este ejercicio concreto ya se haya hecho.',
   'https://www.nasa.gov/missions/analog-field-testing/what-is-basalt/'),
  ('basalt', 2, 'rovers',
   'Propuesta: comparar rutas de un rover por superficies volcánicas previamente caracterizadas, con igual carga, ruedas y velocidad objetivo.',
   'Patinaje, energía por metro, error de posición, obstáculos detectados e intervenciones por recorrido.',
   'Acceso autorizado y trayecto inspeccionado. Los resultados de tracción deben corregirse antes de extrapolarlos a gravedad lunar o marciana.',
   'https://www.nasa.gov/missions/analog-field-testing/what-is-basalt/'),
  ('canapa', 1, 'science',
   'Propuesta: planear una campaña no invasiva que compare luz, temperatura y salinidad en sectores autorizados de las lagunas Cañapa y Chiarkota.',
   'Cobertura de estaciones, incertidumbre de sensores y cambios de condiciones por sitio y hora; blancos si se autoriza muestreo.',
   'F4: propuesto; F2, sección 4.7, como método. Sin fuente específica del ejercicio (source null). No afirmar comunidades microbianas no verificadas ni entrar a orillas sensibles.',
   null),
  ('cerro-rico', 1, 'science',
   'Propuesta: clasificar espectros o muestras de referencia autorizadas de alteración ácida y contrastar la identificación de minerales con un análisis de laboratorio.',
   'Aciertos por mineral, falsos positivos, calidad espectral y trazabilidad entre muestra, ubicación y análisis.',
   'F4: sugerido; falta fuente específica del ejercicio (source null). Priorizar datos existentes o muestras de archivo. No entrar en labores mineras ni manipular drenajes sin especialistas.',
   null),
  ('coipasa', 1, 'rovers',
   'Propuesta de F2: repetir un recorrido autorizado con el mismo rover y configuración usados en Uyuni, sobre clases de superficie previamente inspeccionadas.',
   'Patinaje, energía por metro, error lateral y falsas clasificaciones de terreno transitable por tipo de superficie.',
   'F4: estudiado para el sitio, no para este ensayo. F2, sección 4.2; sin fuente de campaña específica (source null). Verificar costra y evitar agua, ecosistemas y sectores blandos.',
   null),
  ('coipasa', 2, 'astronauts',
   'Propuesta de F2: interpretar imágenes de la cuenca y delimitar zonas seguras para observaciones de depósitos salinos sin extracción.',
   'Concordancia con el mapa validado, riesgos omitidos, estaciones completadas y tiempo de planificación.',
   'F2, sección 4.2; falta fuente específica de ejecución (source null). Permisos, reconocimiento local y protección de costras; no deducir firmeza solo de una fotografía.',
   null),
  ('concordia', 1, 'habitats',
   'Propuesta: simular mantenimiento y reparto de tareas de un hábitat durante aislamiento, registrando carga de trabajo y necesidades de apoyo.',
   'Tareas completadas, tiempo de mantenimiento, incidencias, consumo de suministros del ejercicio y carga de trabajo declarada.',
   'No interrumpir servicios esenciales ni introducir aislamiento adicional sin evaluación. Los estudios con personas requieren consentimiento y supervisión; la evacuación invernal puede no ser posible.',
   'https://www.esa.int/Science_Exploration/Human_and_Robotic_Exploration/Concordia/Spaceship_Concordia'),
  ('cordillera-real', 1, 'science',
   'Propuesta: cartografiar cambios del frente glaciar y del terreno recién expuesto mediante imágenes repetidas y puntos de referencia estables.',
   'Error de posición del frente, cambio de superficie, cobertura del mapa e incertidumbre debida a nieve y sombras.',
   'F4: sugerido; sin fuente específica de entrenamiento (source null). Priorizar imágenes; no ingresar a hielo, grietas o laderas inestables sin personal especializado.',
   null),
  ('desierto-dali', 1, 'rovers',
   'Propuesta: evaluar navegación visual sobre un modelo digital de superficies áridas y comparar imágenes con distintas sombras.',
   'Error de localización, pérdida de seguimiento, colisiones simuladas y porcentaje de ruta completada.',
   'F4: propuesto; método de F2, secciones 8 y 11. Sin fuente específica del ejercicio (source null). Usar imágenes autorizadas; una simulación no valida la tracción real.',
   null),
  ('el-tatio', 1, 'science',
   'Propuesta: distinguir texturas de sílice que podrían conservar señales de vida mediante imágenes y espectros de referencia.',
   'Aciertos de clasificación, falsos positivos y calidad de la descripción de alternativas biológicas y no biológicas.',
   'Usar datos o muestras de archivo; cualquier muestreo exige permiso. No caminar sobre costras termales. Las texturas parecidas no prueban vida en Home Plate.',
   'https://www.nature.com/articles/ncomms13554'),
  ('glaciares-roca', 1, 'science',
   'Propuesta: delimitar glaciares de roca en imágenes y comparar la clasificación de formas activas y relictas con el inventario publicado.',
   'Coincidencia de límites, precisión de la clasificación, área estimada y casos de incertidumbre.',
   'F4: estudiado para el inventario. Las imágenes no miden por sí solas el hielo interno. Verificación de campo solo con autorización y evaluación de estabilidad.',
   'https://doi.org/10.1002/ppp.1816'),
  ('grand-canyon', 1, 'astronauts',
   'Propuesta: describir una secuencia de capas desde miradores autorizados y transmitir al equipo remoto una interpretación con fotografías y escala.',
   'Contactos identificados, concordancia con la sección de referencia y calidad del reporte dentro del tiempo asignado.',
   'El USGS documenta precedentes de formación geológica, no este ejercicio exacto. Respetar senderos y patrimonio; sin extraer rocas ni acercarse a bordes para colocar escalas.',
   'https://www.usgs.gov/science/science-explorer/planetary-science/terrestrial-analogs'),
  ('guapore', 1, 'science',
   'Propuesta: contrastar fotografías y análisis de rocas antiguas con distintos grados de meteorización, indicando qué minerales requieren confirmación instrumental.',
   'Aciertos respecto del análisis de referencia, hipótesis descartadas y trazabilidad de las muestras.',
   'F4: sugerido; falta fuente específica del ejercicio (source null). Usar colecciones autorizadas; la edad de la corteza no demuestra la misma alteración que Mawrth Vallis.',
   null),
  ('haughton', 1, 'astronauts',
   'Propuesta: planear una travesía de reconocimiento de unidades de impacto y justificar qué estaciones aportan más información científica.',
   'Unidades reconocidas, prioridades justificadas, tiempo de recorrido y calidad de documentación por estación.',
   'Requiere coordinación con responsables locales, permisos y apoyo polar. La erosión puede ocultar rasgos; no extrapolar distancias de marcha a la gravedad lunar.',
   'https://www.marsinstitute.no/hmp'),
  ('haughton-hmp', 1, 'rovers',
   'Propuesta: ensayar cooperación entre un rover y un equipo de campo con cortes y demoras artificiales en el enlace de misión.',
   'Objetivos completados, intervenciones, recuperación de enlace, error de mapa y tiempo de decisión.',
   'El campamento es un precedente, no prueba de este protocolo concreto. Mantener un enlace de seguridad independiente y operar solo en corredores autorizados.',
   'https://www.marsinstitute.no/hmp'),
  ('haughton-hmp', 2, 'habitats',
   'Propuesta: simular inventario, mantenimiento y salida de equipos desde una base remota con un presupuesto de suministros definido.',
   'Errores de inventario, tareas terminadas, repuestos solicitados y tiempo de preparación y retorno.',
   'No restringir suministros reales ni alterar soporte esencial del campamento. El ejercicio no certifica un hábitat presurizado.',
   'https://www.marsinstitute.no/hmp'),
  ('hi-seas', 1, 'habitats',
   'Propuesta: organizar rutinas de trabajo, mantenimiento e inventario durante una estancia simulada y revisar cómo afectan a la coordinación.',
   'Tareas pendientes, cumplimiento del plan, errores de inventario y carga de trabajo registrada voluntariamente.',
   'Adaptar el protocolo a la instalación y sus responsables. Consentimiento para datos personales; no restringir soporte vital ni crear emergencias reales.',
   'https://www.hi-seas.org/about-hi-seas'),
  ('intersalar', 1, 'astronauts',
   'Propuesta: reconocer domos y depósitos volcánicos en imágenes y elegir afloramientos que permitan comprobar su origen.',
   'Unidades delimitadas, confianza declarada y concordancia con una interpretación revisada por geólogos.',
   'F4: sugerido y ubicación aproximada; sin fuente específica de entrenamiento (source null). Primero verificar el afloramiento y los permisos; no tratar ignimbritas como basalto lunar.',
   null),
  ('italia-perdida', 1, 'rovers',
   'Propuesta: crear un modelo digital de formas erosivas con fotografías autorizadas y evaluar rutas alrededor de salientes y pasos estrechos.',
   'Error del modelo, obstáculos omitidos, colisiones simuladas y rutas completadas.',
   'F4: sugerido; método de F2, sección 8. Falta fuente específica del ejercicio (source null). Proteger formaciones; usar simulación, sin circular sobre relieves frágiles.',
   null),
  ('iturralde', 1, 'science',
   'Propuesta: comparar mapas de elevación e imágenes de la depresión y formular hipótesis alternativas para explicar su forma circular.',
   'Perfil del relieve, incertidumbre de altura, rasgos diagnósticos encontrados y evidencia que falta para distinguir hipótesis.',
   'F4: propuesto. Ejercicio remoto; la visualización de NASA no confirma impacto. Cualquier campaña necesita permisos y coordinación con comunidades y autoridades locales.',
   'https://svs.gsfc.nasa.gov/925/'),
  ('kilauea', 1, 'science',
   'Propuesta: identificar texturas de lavas y comparar muestras o imágenes con análisis de referencia para separar composición y aspecto superficial.',
   'Aciertos de clasificación, calidad de descripciones y diferencias entre identificación visual e instrumental.',
   'Usar imágenes o colecciones autorizadas y respetar cierres volcánicos. No acercarse a lava activa, gases o bordes inestables para el ejercicio.',
   'https://www.usgs.gov/publications/geology-kilauea-volcano'),
  ('lago-poopo', 1, 'science',
   'Propuesta: reconstruir cambios de superficie de agua y de depósitos expuestos mediante una serie de imágenes fechadas.',
   'Área por fecha, error de clasificación agua/suelo, cobertura temporal e incertidumbre por nubes y humedad.',
   'F4: sugerido; sin fuente específica de entrenamiento (source null). No confundir una imagen seca con desaparición permanente ni interpretar efectos humanos como equivalencia del clima marciano.',
   null),
  ('lago-tauca', 1, 'astronauts',
   'Propuesta: reconocer paleoorillas y terrazas en imágenes y ordenar evidencias de antiguos cambios de nivel del agua.',
   'Niveles delimitados, coherencia de perfiles de altura y relaciones temporales justificadas con la referencia disponible.',
   'F4: sugerido; falta fuente específica del ejercicio (source null). No asignar edades solo por altura; observación o muestras de archivo antes que extracción nueva.',
   null),
  ('laguna-blanca-termal', 1, 'science',
   'Propuesta: diseñar una cadena de registro y control de contaminación para estudiar una fuente termal, usando muestras artificiales fuera del ecosistema.',
   'Etiquetas correctas, blancos sin contaminar, registros completos y tiempo de traslado al análisis.',
   'F4: estudiado para el sitio; método de F2, sección 4.7. Sin fuente específica del ejercicio (source null). Confirmar ubicación; sin entrar al agua ni tocar costras termales.',
   null),
  ('laguna-colorada', 1, 'science',
   'Propuesta: comparar espectros de boratos de referencia con imágenes de depósitos y explicar qué puede y qué no puede deducirse del boro.',
   'Identificaciones confirmadas, falsos positivos y afirmaciones que requieren análisis adicional.',
   'F4: sugerido; sin fuente específica de entrenamiento (source null). No equiparar boro con bórax marciano. Priorizar datos de archivo y no perturbar fauna u orillas.',
   null),
  ('laguna-verde', 1, 'science',
   'Propuesta: documentar depósitos de antiguas orillas y diferenciar señales biológicas posibles de formas que también pueden surgir sin vida.',
   'Observaciones con ubicación y escala, alternativas consideradas y concordancia con análisis de referencia.',
   'F4: estudiado. Usar imágenes o muestreo autorizado; no extraer microbialitos. No trasladar evidencias de vida terrestre a Jezero.',
   'https://doi.org/10.1029/2008JG000818'),
  ('lanzarote-pangaea', 1, 'astronauts',
   'Propuesta basada en PANGAEA: reconocer unidades volcánicas, seleccionar objetivos y comunicar la historia geológica al equipo remoto.',
   'Unidades correctamente relacionadas, calidad de muestras o fotografías autorizadas y claridad del informe en el tiempo disponible.',
   'Coordinar con gestores del terreno y programa. No se afirma que esta variante ya se haya realizado; no retirar muestras ni entrar en cavidades sin autorización.',
   'https://www.esa.int/Science_Exploration/Human_and_Robotic_Exploration/CAVES_and_Pangaea/What_is_PANGAEA'),
  ('la-salsa', 1, 'science',
   'Propuesta: analizar imágenes y datos de depósitos de calcio y sílice para distinguir aportes químicos y biológicos a lo largo de una surgencia.',
   'Cambios minerales identificados, coincidencia con datos publicados y falsos positivos en la búsqueda de señales biológicas.',
   'F4: estudiado. Trabajar primero con el estudio y sus muestras de referencia; acceso y muestreo requieren permisos. No pisar montículos ni tapetes microbianos.',
   'https://doi.org/10.3390/min9060380'),
  ('licancabur', 1, 'science',
   'Propuesta: comparar registros fechados de luz, temperatura y química de lagos de altura para formular preguntas sobre límites de habitabilidad.',
   'Series con metadatos completos, incertidumbre instrumental y relaciones que se mantienen al separar lagos y fechas.',
   'F4: estudiado; High-Lakes es el precedente. No combinar máximos de campañas distintas ni generalizar irradiancia a toda Bolivia. Campo solo con permisos y apoyo especializado de altura.',
   'https://astrobiology.nasa.gov/nai/annual-reports/2008/objective-4.1/index.html'),
  ('licancabur', 2, 'suits',
   'Propuesta de F2: comparar muestras de tejido o recubrimiento de un prototipo bajo exposición ambiental registrada, con controles protegidos.',
   'Exposición UV medida, temperatura del material y cambio de propiedades ópticas o mecánicas respecto del control.',
   'F2, secciones 6 y 8; sin fuente específica de ensayo en este sitio (source null). Usar probetas, no personas. El UV terrestre no valida protección contra rayos cósmicos ni soporte vital.',
   null),
  ('mcmurdo', 1, 'science',
   'Propuesta: interpretar imágenes de suelos congelados y patrones de superficie, separando lo observado de las hipótesis sobre hielo interno.',
   'Patrones delimitados, desacuerdos entre observadores y proporción de hipótesis que cuentan con mediciones independientes.',
   'Propuesta del catálogo, sin fuente específica del ejercicio (source null). Priorizar datos públicos; campo sujeto a permisos antárticos y control de contaminación.',
   null),
  ('mdrs', 1, 'astronauts',
   'Propuesta: planear y ejecutar una salida geológica simulada con presupuesto de tiempo, reporte remoto y retorno documentado.',
   'Objetivos completados, tiempo de preparación y retorno, calidad de informes y cumplimiento de criterios de interrupción.',
   'Coordinar con la estación. Reglas de demora y traje dependen de la campaña; los equipos del ejercicio no se presuponen presurizados ni aptos para vuelo.',
   'https://mdrs.marssociety.org/'),
  ('mdrs', 2, 'habitats',
   'Propuesta: simular gestión de inventario y mantenimiento del hábitat durante una misión con roles y turnos definidos.',
   'Faltantes de inventario, tareas pendientes, errores de traspaso de turno y tiempo de solución de incidencias ficticias.',
   'No alterar servicios esenciales ni bloquear salidas. Cualquier toma de datos de tripulación exige consentimiento y acuerdos de privacidad.',
   'https://mdrs.marssociety.org/'),
  ('meteor-crater', 1, 'astronauts',
   'Propuesta: reconocer borde, eyecta y rocas alteradas por impacto y justificar un conjunto de observaciones geológicas.',
   'Rasgos identificados, concordancia con el mapa de referencia y calidad de las razones para seleccionar cada objetivo.',
   'USGS documenta entrenamiento Apollo, no este ejercicio exacto. Acceso con responsables del sitio; no recoger fragmentos ni abandonar rutas autorizadas.',
   'https://www.usgs.gov/centers/astrogeology-science-center/science/meteor-crater-sample-collection'),
  ('ollague', 1, 'science',
   'Propuesta: delimitar domos y coladas en imágenes y comparar qué rasgos se conservan mejor en un paisaje árido.',
   'Límites de unidades, confianza de interpretación y coincidencia con cartografía geológica revisada.',
   'F4: sugerido; sin fuente específica de entrenamiento (source null). Trabajo remoto preferente. No tratar un estratovolcán como un escudo basáltico ni entrar a sectores volcánicos restringidos.',
   null),
  ('pastos-grandes', 1, 'science',
   'Propuesta: establecer un protocolo de descripción de carbonatos y posibles señales microbianas usando imágenes y datos publicados como referencia.',
   'Rasgos documentados, repetibilidad de la clasificación, falsos positivos y trazabilidad de cada interpretación.',
   'F4: estudiado. El ejercicio no demuestra origen biológico de carbonatos en Marte. Muestreo solo autorizado; no afectar costras ni ecosistemas termales.',
   'https://doi.org/10.3390/min9060380'),
  ('permafrost-occidental', 1, 'science',
   'Propuesta: diseñar una serie de mediciones de temperatura del suelo que permita distinguir heladas diarias de suelo permanentemente congelado.',
   'Continuidad de la serie, profundidad y calibración de sensores, duración de congelación y datos faltantes.',
   'F4: sugerido y ubicación aproximada; sin fuente específica del ejercicio (source null). Verificar el sitio y permisos; una noche bajo cero no demuestra permafrost.',
   null),
  ('rio-tinto', 1, 'science',
   'Propuesta: identificar minerales de hierro en espectros de referencia y revisar qué otras mediciones se necesitan para interpretar un ambiente ácido.',
   'Precisión por mineral, falsos positivos y coherencia con pH y análisis químicos disponibles.',
   'Propuesta del catálogo sin fuente específica del ejercicio (source null). Usar datos o muestras autorizadas; no manipular aguas ácidas sin laboratorio y personal especializado.',
   null),
  ('sajama', 1, 'rovers',
   'Propuesta de F2: comparar arranques de batería y recorridos cortos sobre pendientes conocidas, manteniendo carga y configuración constantes.',
   'Temperatura y voltaje iniciales, tiempo de arranque, energía por metro, patinaje y estabilidad.',
   'F2, sección 4.4: candidato por procesos; sin fuente de campaña específica (source null). Límites de batería del fabricante, pista autorizada y protección antivuelco; evitar bofedales y patrimonio.',
   null),
  ('sajama', 2, 'suits',
   'Propuesta de F2: practicar manejo de instrumentos con guantes de un prototipo no presurizado sobre una mesa o pista autorizada.',
   'Tiempo de tarea, errores, objetos caídos y comodidad declarada, comparados con una línea base sin esos guantes.',
   'F2, secciones 4.4 y 8; sin fuente específica del ejercicio (source null). No usar personas para probar frío extremo ni reducción de presión. La prueba de destreza no certifica un traje EVA.',
   null),
  ('sajama-hielo', 1, 'science',
   'Propuesta: interpretar perfiles de núcleos de hielo publicados y ordenar qué cambios ambientales pueden explicar sus capas.',
   'Capas reconocidas, incertidumbre temporal y concordancia con la cronología y mediciones del estudio.',
   'F4: sugerido como análogo. El trabajo citado corresponde a los núcleos de hielo del Sajama. Usar archivos, sin nueva perforación ni ingreso a glaciares.',
   'https://doi.org/10.1126/science.282.5395.1858'),
  ('salares-capas', 1, 'astronauts',
   'Propuesta: elaborar una columna de capas a partir de perfiles e imágenes autorizados y explicar alternancias entre sedimentos de lago y depósitos de sal.',
   'Orden correcto de capas, contactos documentados, calidad del esquema y separación entre observaciones e hipótesis.',
   'F4: estudiado para el sitio; método de F2. Sin fuente específica de entrenamiento (source null). No perforar ni extraer material sin permiso; no asignar minerales por color.',
   null),
  ('salda', 1, 'science',
   'Propuesta: comparar depósitos de costa y carbonatos en mapas e imágenes y formular un plan de observación aplicable a un antiguo lago.',
   'Unidades reconocidas, objetivos justificados y correspondencia con análisis minerales de referencia.',
   'El vínculo con Jezero respalda el contexto, no que este protocolo se haya ejecutado. Proteger orillas y depósitos; observar vida terrestre no demuestra vida en Marte.',
   'https://science.nasa.gov/blogs/earth-matters/2021/02/17/what-a-lake-in-turkey-can-tell-us-about-mars/'),
  ('siloli', 1, 'rovers',
   'Propuesta: probar reconstrucción 3D y detección de obstáculos con imágenes de rocas erosionadas y distintas sombras.',
   'Error de profundidad, obstáculos omitidos, falsas alarmas y porcentaje de rutas virtuales completadas.',
   'F4: propuesto; método de F2, sección 8. Sin fuente específica del ejercicio (source null). Usar imágenes autorizadas o réplicas; no usar el Árbol de Piedra como pista.',
   null),
  ('sol-de-manana', 1, 'science',
   'Propuesta: definir estaciones de observación remota para reconocer alteración hidrotermal y separar objetivos seguros de zonas excluidas.',
   'Cobertura de imágenes, riesgos omitidos, confianza de identificación y mediciones adicionales necesarias para confirmar minerales.',
   'F4: sugerido; F2 excluye operaciones en fumarolas. Sin fuente específica de entrenamiento (source null). No entrar en costras frágiles, barro ni gases; emplear datos existentes o puntos autorizados.',
   null),
  ('sud-lipez', 1, 'rovers',
   'Propuesta de F2: repetir recorridos sobre terreno firme, grava y obstáculos autorizados con un perfil de misión constante.',
   'Patinaje, energía por metro, intervenciones, tiempo total y éxito de recuperación tras una pérdida de enlace simulada.',
   'F2, sección 4.3: propuesta sin fuente específica de campaña (source null). Permisos de la reserva; excluir fumarolas, orillas, vegetación y fauna. Interrumpir ante cambios de seguridad.',
   null),
  ('sud-lipez', 2, 'astronauts',
   'Propuesta de F2: priorizar estaciones geológicas y coordinar observaciones con un equipo remoto usando una demora artificial definida.',
   'Calidad de informes, tareas terminadas, tiempo de decisión, retorno y carga de trabajo.',
   'F2, secciones 4.3 y 8; sin fuente específica de ejecución (source null). Canal de seguridad sin demora, apoyo real y evaluación de altura; no improvisar una EVA con soporte vital experimental.',
   null),
  ('tajzara', 1, 'science',
   'Propuesta: comparar perfiles e imágenes repetidas de dunas para estimar cambios de forma y desplazamiento de arena.',
   'Desplazamiento con incertidumbre, cambios de perfil, intervalo entre observaciones y condiciones de viento registradas.',
   'F4: propuesto; sin fuente específica de entrenamiento (source null). Preferir imágenes o puntos autorizados; no extrapolar el viento terrestre directamente a Marte ni alterar dunas y humedales.',
   null),
  ('tata-sabaya', 1, 'science',
   'Propuesta: cartografiar montículos y límites del depósito de avalancha en un modelo de elevación y contrastar hipótesis de movimiento de ladera.',
   'Área delimitada, dimensiones con incertidumbre y concordancia con el depósito descrito en el estudio.',
   'F4: sugerido como análogo; el estudio respalda la geología terrestre. No equiparar escala y gravedad con Marte. Usar datos remotos antes de cualquier campaña autorizada.',
   'https://doi.org/10.5027/andgeoV39n3-a03'),
  ('torotoro', 1, 'astronauts',
   'Propuesta de F2: describir contactos entre capas con fotografías y comunicar una interpretación al equipo remoto dentro de un tiempo asignado.',
   'Contactos reconocidos, informes completos, tiempo de decisión y concordancia con una referencia revisada por especialistas.',
   'F4: sugerido; F2, sección 4.6. Sin fuente específica de ejecución (source null). Protección estricta de fósiles y formaciones; sin extracción ni salida de senderos autorizados.',
   null),
  ('torotoro', 2, 'rovers',
   'Propuesta de F2: evaluar segmentación de estratos y planificación de rutas sobre fotografías o un modelo digital validado.',
   'Precisión y recuperación de estratos, error del mapa, colisiones simuladas y rutas completadas.',
   'F2, sección 4.6; sin fuente específica del ejercicio (source null). No circular sobre patrimonio. Un modelo visual no demuestra capacidad de ascenso real ni equivalencia geológica con Marte.',
   null),
  ('umajalanta', 1, 'rovers',
   'Propuesta: evaluar navegación sin GNSS y cartografía de pasos subterráneos en un modelo digital o réplica de la cueva.',
   'Error del mapa, pérdidas de seguimiento, cobertura, recuperación de enlace y colisiones simuladas.',
   'F4: sugerido; sin fuente específica del ejercicio (source null). Priorizar modelos; campo solo con autorización y especialistas. La cueva caliza no reproduce un tubo de lava lunar.',
   null),
  ('uyuni', 1, 'astronauts',
   'Propuesta de F2: planificar observaciones no invasivas de depósitos y costras dentro de un presupuesto de tiempo, con apoyo científico remoto.',
   'Objetivos completados, calidad de fotografías y registros, tiempo de retorno y riesgos correctamente identificados.',
   'F4: propuesto por NASA para el sitio; F2, sección 4.1. Sin fuente específica del ejercicio (source null). Sectores autorizados y costra evaluada; no perforar ni asumir firmeza homogénea.',
   null),
  ('uyuni', 2, 'suits',
   'Propuesta de F2: evaluar cambios en probetas de cubiertas y conectores expuestos al ambiente salino, comparándolos con controles protegidos.',
   'Sal depositada, cambio de transmitancia, resistencia de contacto y daños tras una limpieza definida.',
   'F2, secciones 4.1 y 8; sin fuente específica de campaña (source null). Probetas recuperables, sin liberar materiales ni ensuciar el salar. No equivale a abrasión por polvo lunar ni certifica un traje.',
   null),
  ('uyuni', 3, 'science',
   'Propuesta: reproducir una comparación cartográfica de cloruros con imágenes orbitales y explicar similitudes y diferencias entre Uyuni e Icaria Planum.',
   'Límites de depósitos, coincidencia entre observadores, incertidumbre de resolución y evidencia espectral de cada clasificación.',
   'El resumen de congreso respalda la comparación, no una identidad completa. No inferir percloratos ni vida; usar coordenadas y datos originales, sin trasladar cifras no verificadas.',
   'https://doi.org/10.5194/epsc2024-483'),
  ('uyuni', 4, 'rovers',
   'Propuesta de F2: recorrer una ruta inspeccionada usando cámara e IMU, reservando GNSS como referencia externa de evaluación.',
   'Error lateral y final, deriva por distancia, pérdidas de seguimiento y energía por metro.',
   'F2, sección 4.1; sin fuente específica de ensayo realizado (source null). No degradar la comunicación de seguridad; verificar costra, luz y humedad. Sin circular por agua o sectores inciertos.',
   null),
  ('uyuni', 5, 'rovers',
   'Propuesta de F2: clasificar imágenes de costras y evaluar si el sistema reconoce incertidumbre y solicita detención antes de avanzar.',
   'Falsos negativos de terreno inseguro, falsas alarmas, tiempo de detención y solicitudes de ayuda correctas.',
   'F2, secciones 4.1 y 8; sin fuente específica del ejercicio (source null). Usar un conjunto etiquetado o una pista de réplica; no comprobar errores conduciendo hacia costras peligrosas.',
   null),
  ('uyuni', 6, 'science',
   'Propuesta: medir tamaño y separación de polígonos en imágenes y contrastar explicaciones por salmuera, hielo o contracción sin decidir solo por su forma.',
   'Distribución de tamaños, incertidumbre de escala y evidencia independiente necesaria para cada hipótesis.',
   'F4: estudiado para el mecanismo de polígonos salinos. El estudio no demuestra la causa de cada polígono local ni de los marcianos. No abrir zanjas ni alterar costras.',
   'https://doi.org/10.1103/PhysRevX.13.011025'),
  ('uyuni', 7, 'science',
   'Propuesta: practicar registro, blancos y trazabilidad de un estudio de salmueras con muestras artificiales de composición conocida.',
   'Errores de etiquetado, blancos contaminados, recuperación de componentes conocidos y registros completos.',
   'F4: estudiado para el sitio; método de F2, sección 4.7. Sin fuente específica del ejercicio (source null). No atribuir percloratos a Uyuni ni agua actual a las RSL; sin extracción no autorizada.',
   null),
  ('valle-de-la-luna', 1, 'rovers',
   'Propuesta de F2: construir un modelo digital con fotografías autorizadas y probar detección de bordes y rutas entre cárcavas.',
   'Error de reconstrucción, obstáculos omitidos, falsas detecciones por sombras y rutas virtuales completadas.',
   'F2, sección 4.5: candidato metodológico sin fuente específica de ejecución (source null). No usar formaciones originales como pista; trabajar con gemelos digitales o réplicas.',
   null),
  ('valle-de-la-luna', 2, 'astronauts',
   'Propuesta de F2: interpretar pendientes y formas erosivas desde imágenes y explicar qué observaciones permiten distinguir procesos geológicos.',
   'Riesgos reconocidos, calidad de hipótesis, referencias fotográficas y tiempo de reporte.',
   'F2, sección 4.5; sin fuente específica del ejercicio (source null). Solo senderos y observaciones permitidos; el nombre del sitio no implica geología lunar.',
   null)
on conflict (analog_id, position) do update set
  audience = excluded.audience,
  activity = excluded.activity,
  measures = excluded.measures,
  restrictions = excluded.restrictions,
  source = excluded.source;
