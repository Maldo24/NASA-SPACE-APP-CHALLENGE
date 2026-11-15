# Costos de los entrenamientos en nuestros análogos

Este informe estima **en qué se gasta, cuánto tiempo toma y cuánto costaría** cada entrenamiento que la página propone para los 56 análogos (82 entrenamientos en total, tomados de `src/data/analogs.json`). Complementa a [COSTOS-MISIONES-LUNARES.md](COSTOS-MISIONES-LUNARES.md).

**Punto de partida:** los que entrenan son **astronautas que salen de Houston** (Centro Espacial Johnson de la NASA). Por eso **todos los sitios son destinos de viaje, también los de Bolivia**, y cada salida al campo incluye pasajes, viáticos y días de viaje.

**Importante:** casi nada de esto tiene precio público. Las cifras son **estimaciones de orden de magnitud** armadas con unos pocos precios públicos (sección 2). Sirven para comparar análogos entre sí, no como presupuesto.

---

## 1. Resumen

**Tres formas de hacer un entrenamiento**

| Modo | Entrenamientos | Qué es | Tiempo típico | En qué se gasta |
|---|---|---|---|---|
| **Gabinete** | 38 | Con imágenes de satélite, modelos digitales, datos publicados o muestras de referencia | 1–2 semanas de trabajo parcial, **sin viajar** | Casi nada: horas de las personas. Los datos y los programas son gratuitos. |
| **Campo** | 40 | Ir al lugar a recorrer, medir, probar un rover o tomar fotos | 3–10 días fuera de casa | **Pasajes desde Houston**, viáticos (alojamiento y comida), vehículos, entradas y permisos. En Bolivia: 2 días para aclimatarse a la altura y control médico. Con rover: el rover, su envío, baterías y GNSS. |
| **Hábitat** | 4 | Vivir aislados en una estación (MDRS, HI-SEAS, Concordia, Haughton) | 2 semanas a 1 año | Cuotas u operación de la estación, más los pasajes |

**Lo que cuesta, para un equipo de 6 astronautas**
- **Gabinete:** 24 análogos solo tienen entrenamientos de gabinete. Cuestan **casi US$ 0** porque no hace falta viajar.
- **Una salida de campo a Bolivia:** entre **US$ 12.200 y 26.400**, según el sitio. Solo los pasajes de ida y vuelta Houston–Bolivia suman **US$ 10.800–12.000**, es decir **más de la mitad** del costo de las salidas cortas.
- **Las 12 salidas de campo de Bolivia**, cada una en un viaje distinto, costarían **US$ 163.000–271.600**.
- **Las mismas 12 salidas en un solo viaje largo** (pasajes y aclimatación una sola vez) costarían **US$ 34.300–108.200**. Se ahorra **entre 60 % y 80 %**.
- **Comparación con otros países:** una salida a Arizona cuesta **US$ 5.600–9.100**, porque el vuelo es nacional. A Bolivia cuesta un poco más que a Europa o Chile (US$ 10.000–20.000). Lo más caro es el Ártico canadiense, la Antártida, China y Rusia.
- **Hábitats** (datos públicos más pasajes): **MDRS, US$ 18.000–29.400** por rotación de 2 semanas; **HI-SEAS, unos US$ 405.000** por misión.

**La idea principal:** en Bolivia, lo que más cuesta es **llegar**. Por eso conviene (1) hacer primero todo lo de gabinete sin viajar y (2) juntar todas las salidas de campo en **un solo viaje** bien planificado.

---

## 2. Cómo se calculó

**Precios públicos de referencia**
| Concepto | Precio | Fuente |
|---|---|---|
| Viáticos del gobierno de EE.UU. en La Paz | **US$ 238 por día** como máximo (US$ 140 de alojamiento + US$ 98 de comida y gastos) | [Departamento de Estado](https://allowances.state.gov/web920/per_diem_action.asp?MenuHide=1&CountryCode=1040) |
| Viáticos en Potosí y "resto de Bolivia" | **US$ 152** y **US$ 130 por día** | Misma fuente |
| Pasaje de gobierno de EE.UU. a La Paz (tarifa por tramo, histórica) | **≈ US$ 900–975 por tramo** (2012–2017) | [FedFlights, datos del programa City Pair de GSA](https://www.fedflights.com/international/bolivia/2017) |
| Viáticos estándar dentro de EE.UU. | **US$ 178 por día** (US$ 110 + US$ 68) | Tarifa estándar de GSA |
| Tour compartido de 3 días en Uyuni (4x4, chofer, comidas y alojamiento) | **US$ 229 por persona** (≈ US$ 75 por día) | [Nomades](https://www.nomades.com/uyuni/salar-de-uyuni-3-dias-id516) |
| Entrada a la Reserva Eduardo Avaroa | **Bs 150** (≈ US$ 22 con 6,96 Bs por dólar) | [Komoot](https://www.komoot.com/highlight/6106943); no se encontró la tarifa oficial del SERNAP |
| Rotación en MDRS (2 semanas) | **US$ 2.000–3.500** + depósito de US$ 250 por persona | [Purdue MDRS](https://sites.google.com/view/purduemdrscrews/home) |
| Misión en HI-SEAS | **≈ US$ 400.000** | [Universidad de Hawái](https://www.hawaii.edu/news/2013/06/14/long-duration-space-exploration-study-awarded-nasa-grant/) |

**Pasajes y gasto diario por región (estimación)**

Solo los valores de Bolivia y EE.UU. salen de las fuentes de arriba. Los demás son **estimaciones nuestras** de pasajes en clase económica desde Houston.

| Región | Pasaje ida y vuelta por persona | Gasto por persona y día |
|---|---|---|
| Bolivia | US$ 1.800–2.000 | US$ 75–238 |
| EE.UU. continental | US$ 400–800 | US$ 178 |
| Hawái | US$ 800–1.400 | US$ 250–350 |
| Chile | US$ 1.200–2.000 | US$ 150–250 |
| Canadá (Labrador) | US$ 1.500–3.000 | US$ 200–300 |
| Ártico canadiense | US$ 3.000–6.000 | US$ 250–400 |
| Europa y Turquía | US$ 1.200–2.000 | US$ 200–300 |
| China y Rusia | US$ 2.000–3.500 | US$ 150–300 |

**Supuestos (nuestros, no datos públicos)**
- **Equipo de 6 astronautas** que salen de Houston.
- **En Bolivia:** 2 días de aclimatación en La Paz, a 3.600 m, antes de ir al campo. Los viajes de ida y vuelta desde La Paz duran 0 días si el sitio está cerca, 2 si está a un día y 3 si es remoto. El gasto diario va de US$ 75 (como el tour compartido) a US$ 238 (viático máximo del gobierno de EE.UU. en La Paz).
- **Días en el sitio según el público:** astronautas y ciencia, 1–2; trajes, 2–3; rovers, 3–5. Las salidas solo para tomar fotos, 1–2.
- **Fuera de Bolivia:** 2 días de viaje, más los días en el sitio.
- **No incluye** sueldos, seguros, el rover ni los instrumentos, ni su envío. Mandar un rover a otro país puede costar tanto como los pasajes.
- **Cómo se clasificó cada entrenamiento:** si su texto habla de imágenes, modelos digitales, datos publicados o espectros de referencia, se contó como **gabinete**. Si pide ir al lugar, se contó como **campo**.

---

## 3. Análogo por análogo

### Bolivia: cerca de La Paz (2)

| Análogo | Para quién | Tiempo | En qué se gasta | Costo estimado (equipo de 6) |
|---|---|---|---|---|
| `cordillera-real` Cordillera Real, Bolivia | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `valle-de-la-luna` Valle de la Luna, Mallasa, La Paz, Bolivia | rovers, astronautas | gabinete 1: 1–2 semanas, sin viajar; campo 1: 3–4 días fuera de casa (1–2 en el sitio, 2 de aclimatación en La Paz) | Pasajes desde Houston (Bolivia), viáticos, vehículo 4x4 con chofer, aparte: rover, baterías y GNSS de referencia, y su envío | US$ 12.200–17.700 |

### Bolivia: a 1 día de La Paz (2 días de ida y vuelta) (13)

| Análogo | Para quién | Tiempo | En qué se gasta | Costo estimado (equipo de 6) |
|---|---|---|---|---|
| `umajalanta` Caverna de Umajalanta, Torotoro, Bolivia | rovers | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `cerro-rico` Cerro Rico de Potosí, Bolivia | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `intersalar` Cordillera Intersalar, Bolivia | astronautas | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `sajama-hielo` Glaciar del Sajama, Bolivia | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `lago-poopo` Lago Poopó, Oruro, Bolivia | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `lago-tauca` Paleolagos Tauca y Minchin, Altiplano de Bolivia | astronautas | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `torotoro` Parque Nacional Torotoro, Bolivia | astronautas, rovers | gabinete 1: 1–2 semanas, sin viajar; campo 1: 5–6 días fuera de casa (1–2 en el sitio, 2 de aclimatación en La Paz) | Pasajes desde Houston (Bolivia), viáticos, vehículo 4x4 con chofer, control médico de altura | US$ 13.100–20.600 |
| `permafrost-occidental` Permafrost de la Cordillera Occidental, Bolivia | ciencia | campo 1: 5–6 días fuera de casa (1–2 en el sitio, 2 de aclimatación en La Paz) | Pasajes desde Houston (Bolivia), viáticos, vehículo 4x4 con chofer, control médico de altura | US$ 13.100–20.600 |
| `coipasa` Salar de Coipasa, Bolivia | rovers, astronautas | gabinete 1: 1–2 semanas, sin viajar; campo 1: 7–9 días fuera de casa (3–5 en el sitio, 2 de aclimatación en La Paz) | Pasajes desde Houston (Bolivia), viáticos, vehículo 4x4 con chofer, control médico de altura, aparte: rover, baterías y GNSS de referencia, y su envío | US$ 14.000–24.900 |
| `uyuni` Salar de Uyuni, Bolivia | astronautas, trajes, ciencia, rovers | gabinete 4: 1–2 semanas, sin viajar; campo 3: 7–9 días fuera de casa (3–5 en el sitio, 2 de aclimatación en La Paz) | Pasajes desde Houston (Bolivia), viáticos, vehículo 4x4 con chofer, control médico de altura, aparte: rover, baterías y GNSS de referencia, y su envío | US$ 14.000–24.900 |
| `salares-capas` Salares de Uyuni y Coipasa, Bolivia — capas | astronautas | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `sajama` Volcán Sajama, Bolivia | rovers, trajes | campo 2: 7–9 días fuera de casa (3–5 en el sitio, 2 de aclimatación en La Paz) | Pasajes desde Houston (Bolivia), viáticos, vehículo 4x4 con chofer, control médico de altura, aparte: rover, baterías y GNSS de referencia, y su envío | US$ 14.000–24.900 |
| `tata-sabaya` Volcán Tata Sabaya, Oruro, Bolivia | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |

### Bolivia: sitios remotos (3 días de ida y vuelta) (17)

| Análogo | Para quién | Tiempo | En qué se gasta | Costo estimado (equipo de 6) |
|---|---|---|---|---|
| `desierto-dali` Desierto de Dalí, Sud Lípez, Bolivia | rovers | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `siloli` Desierto de Siloli y Árbol de Piedra, Bolivia | rovers | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `tajzara` Dunas de Tajzara, Tarija, Bolivia | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `guapore` Escudo de Guaporé (cratón amazónico), Bolivia | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `iturralde` Estructura de Iturralde (Araona), La Paz, Bolivia | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `la-salsa` Fuente La Salsa, Laguna Pastos Grandes, Bolivia | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `laguna-blanca-termal` Fuente termal de Laguna Blanca, Sud Lípez, Bolivia | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `glaciares-roca` Glaciares de roca de los Andes de Bolivia (incl. Caquella) | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `italia-perdida` Italia Perdida y Bosque de Piedras, Bolivia | rovers | campo 1: 6–7 días fuera de casa (1–2 en el sitio, 2 de aclimatación en La Paz) | Pasajes desde Houston (Bolivia), viáticos, vehículo 4x4 con chofer, control médico de altura, aparte: rover, baterías y GNSS de referencia, y su envío | US$ 13.500–22.000 |
| `laguna-colorada` Laguna Colorada, Sud Lípez, Bolivia | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `pastos-grandes` Laguna Pastos Grandes, Sud Lípez, Bolivia | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `laguna-verde` Laguna Verde, Sud Lípez, Bolivia | ciencia | campo 1: 6–7 días fuera de casa (1–2 en el sitio, 2 de aclimatación en La Paz) | Pasajes desde Houston (Bolivia), viáticos, vehículo 4x4 con chofer, entrada a la Reserva Eduardo Avaroa, control médico de altura | US$ 13.600–22.100 |
| `canapa` Lagunas Cañapa y Chiarkota, Bolivia | ciencia | campo 1: 6–7 días fuera de casa (1–2 en el sitio, 2 de aclimatación en La Paz) | Pasajes desde Houston (Bolivia), viáticos, vehículo 4x4 con chofer, control médico de altura | US$ 13.500–22.000 |
| `sud-lipez` Reserva Eduardo Avaroa, Sud Lípez, Bolivia | rovers, astronautas | campo 2: 8–10 días fuera de casa (3–5 en el sitio, 2 de aclimatación en La Paz) | Pasajes desde Houston (Bolivia), viáticos, vehículo 4x4 con chofer, entrada a la Reserva Eduardo Avaroa, control médico de altura, aparte: rover, baterías y GNSS de referencia, y su envío | US$ 14.500–26.400 |
| `sol-de-manana` Sol de Mañana, Sud Lípez, Bolivia | ciencia | campo 1: 6–7 días fuera de casa (1–2 en el sitio, 2 de aclimatación en La Paz) | Pasajes desde Houston (Bolivia), viáticos, vehículo 4x4 con chofer, entrada a la Reserva Eduardo Avaroa, control médico de altura | US$ 13.600–22.100 |
| `licancabur` Volcán Licancabur y lagunas Blanca y Verde, Bolivia–Chile | ciencia, trajes | gabinete 1: 1–2 semanas, sin viajar; campo 1: 7–8 días fuera de casa (2–3 en el sitio, 2 de aclimatación en La Paz) | Pasajes desde Houston (Bolivia), viáticos, vehículo 4x4 con chofer, entrada a la Reserva Eduardo Avaroa, control médico de altura | US$ 14.100–23.600 |
| `ollague` Volcán Ollagüe, Bolivia–Chile | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |

### Hábitats y estaciones (4)

| Análogo | Para quién | Tiempo | En qué se gasta | Costo estimado (equipo de 6) |
|---|---|---|---|---|
| `concordia` Estación Concordia, Antártida | hábitats | ≈ 1 año (invernada) | Logística polar: aviones, base y combustible | Sin dato público |
| `haughton-hmp` Haughton-Mars Project, isla Devon, Canadá | rovers, hábitats | campo 1: 16–44 días fuera de casa (14–42 en el sitio) | Pasajes desde Houston (Ártico canadiense), viáticos (alojamiento y comida), transporte local, aparte: rover, baterías y GNSS de referencia, y su envío | US$ 42.000–141.600 |
| `hi-seas` HI-SEAS, Mauna Loa, Hawái, EE.UU. | hábitats | 4 a 12 meses | Operación del hábitat (dato público) y pasajes a Hawái | US$ 404.800–408.400 |
| `mdrs` Mars Desert Research Station, Utah, EE.UU. | astronautas, hábitats | 2 semanas por rotación + 2 días de viaje | Cuota de la estación (equipos, trajes, vehículos), pasaje a Utah y 2 días de viáticos | US$ 18.000–29.400 |

### Otros países (20)

| Análogo | Para quién | Tiempo | En qué se gasta | Costo estimado (equipo de 6) |
|---|---|---|---|---|
| `cinder-lake` Cinder Lake, campo de cráteres de entrenamiento, Arizona, EE.UU. | astronautas, rovers | gabinete 1: 1–2 semanas, sin viajar; campo 1: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (EE.UU. continental), viáticos (alojamiento y comida), transporte local | US$ 5.600–9.100 |
| `haughton` Cráter Haughton, isla Devon, Canadá | astronautas | campo 1: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (Ártico canadiense), viáticos (alojamiento y comida), transporte local | US$ 22.500–45.600 |
| `ries-crater` Cráter Nördlinger Ries, Alemania | astronautas, ciencia | gabinete 1: 1–2 semanas, sin viajar; campo 1: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (Europa y Turquía), viáticos (alojamiento y comida), transporte local | US$ 10.800–19.200 |
| `atacama` Desierto de Atacama, Chile | ciencia | campo 1: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (Chile), viáticos (alojamiento y comida), transporte local | US$ 9.900–18.000 |
| `el-tatio` Géiseres de El Tatio, Chile | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `grand-canyon` Gran Cañón, EE.UU. | astronautas | campo 1: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (EE.UU. continental), viáticos (alojamiento y comida), transporte local | US$ 5.600–9.100 |
| `mistastin` Kamestastin / Mistastin, Labrador, Canadá | astronautas, ciencia | gabinete 1: 1–2 semanas, sin viajar; campo 1: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (Canadá (Labrador)), viáticos (alojamiento y comida), transporte local | US$ 12.600–25.200 |
| `kilauea` Kīlauea, Hawái, EE.UU. | ciencia | campo 1: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (Hawái), viáticos (alojamiento y comida), transporte local | US$ 9.300–16.800 |
| `salda` Lago Salda, Turquía | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `lanzarote-pangaea` Lanzarote, España (ESA PANGAEA) | astronautas | campo 1: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (Europa y Turquía), viáticos (alojamiento y comida), transporte local | US$ 10.800–19.200 |
| `lava-river-cave-az` Lava River Cave, Coconino, Arizona, EE.UU. | rovers, astronautas | gabinete 1: 1–2 semanas, sin viajar; campo 1: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (EE.UU. continental), viáticos (alojamiento y comida), transporte local | US$ 5.600–9.100 |
| `meteor-crater` Meteor Crater, Arizona, EE.UU. | astronautas | campo 1: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (EE.UU. continental), viáticos (alojamiento y comida), transporte local | US$ 5.600–9.100 |
| `basalt` NASA BASALT, Craters of the Moon, Idaho, EE.UU. | astronautas, rovers | campo 2: 5–7 días fuera de casa (3–5 en el sitio) | Pasajes desde Houston (EE.UU. continental), viáticos (alojamiento y comida), transporte local, aparte: rover, baterías y GNSS de referencia, y su envío | US$ 7.700–12.300 |
| `qaidam` Playa de Dalangtan, cuenca de Qaidam, China | ciencia, rovers | campo 3: 5–7 días fuera de casa (3–5 en el sitio) | Pasajes desde Houston (China y Rusia), viáticos (alojamiento y comida), transporte local, aparte: rover, baterías y GNSS de referencia, y su envío | US$ 16.500–33.600 |
| `mauna-kea-isru` Pu'u Hiwahine, Mauna Kea — ensayos ISRU, Hawái, EE.UU. | rovers, ciencia | campo 2: 5–7 días fuera de casa (3–5 en el sitio) | Pasajes desde Houston (Hawái), viáticos (alojamiento y comida), transporte local, aparte: rover, baterías y GNSS de referencia, y su envío | US$ 12.300–23.100 |
| `rio-tinto` Río Tinto, España | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; imágenes, datos y programas gratuitos | ≈ US$ 0 directo |
| `sp-mountain` SP Mountain y su colada, Arizona, EE.UU. | astronautas, rovers | gabinete 1: 1–2 semanas, sin viajar; campo 1: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (EE.UU. continental), viáticos (alojamiento y comida), transporte local | US$ 5.600–9.100 |
| `mcmurdo` Valles Secos de McMurdo, Antártida | ciencia | gabinete 1: 1–2 semanas, sin viajar | Horas de trabajo; datos gratuitos | ≈ US$ 0 directo |
| `tolbachik` Volcán Tolbachik, Kamchatka, Rusia | ciencia | campo 3: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (China y Rusia), viáticos (alojamiento y comida), transporte local | US$ 14.700–28.200 |
| `yakutia` Yakutia Central, cuenca del río Lena, Rusia | ciencia | gabinete 1: 1–2 semanas, sin viajar; campo 1: 3–4 días fuera de casa (1–2 en el sitio) | Pasajes desde Houston (China y Rusia), viáticos (alojamiento y comida), transporte local | US$ 14.700–28.200 |

---

## 4. Cómo bajar costos

1. **Primero gabinete, sin viajar.** 38 de los 82 entrenamientos se hacen desde Houston con imágenes y datos. El modelo digital de Umajalanta o las imágenes de Coipasa preparan la salida y acortan los días en el campo.
2. **Un solo viaje a Bolivia.** Los pasajes son el gasto más grande; pagarlos una sola vez ahorra entre 60 % y 80 %. Una ruta posible:
   - La Paz: aclimatación, Valle de la Luna y Cordillera Real.
   - Sajama.
   - Uyuni y Coipasa.
   - Sud Lípez y la Reserva Eduardo Avaroa.
   - Torotoro.
3. **Probar el rover primero en EE.UU.** Arizona (Cinder Lake, SP Mountain) es mucho más barato desde Houston. Así se llega a Bolivia con los errores ya corregidos.
4. **Aprovechar la altura de Bolivia.** Muchos sitios de Bolivia están a más de 3.600 m: frío, poco oxígeno y radiación UV alta. Eso no lo dan los sitios de Arizona, y justifica el costo del viaje para probar baterías, trajes y personas.
5. **Pedir cotizaciones reales** de pasajes, transporte en 4x4, permisos del SERNAP y alojamiento.

---

## 5. Cálculo afinado de la página (sección "Costo estimado de entrenar aquí")

La ficha de cada análogo usa una versión más detallada de este modelo, en `src/lib/trainingCosts.ts`. Las tablas de arriba usan el modelo general, así que algunos números no coinciden.

**Qué cambia respecto del modelo general**
- **Por persona, no por equipo.** "Por astronauta" es 1 persona y "Por rover" es un equipo de 3 operadores.
- **Suma de días.** Se suman los días de todos los entrenamientos de campo del análogo, en vez de tomar solo el más largo. En los hábitats, todo cabe en la misma estadía de 2 semanas.
- **Días según la actividad, no según el público:**
  - Observación corta: 1–2 días.
  - Travesía, salida geológica o campaña: 2–3.
  - Pruebas de rover en recorridos: 3–5.
  - Instalar y leer instrumentos, o exponer muestras: 3–5.
  - Salida para tomar fotos: 1–2.
- **Aeropuerto y traslado de cada sitio.** Arizona (Flagstaff), Idaho (Idaho Falls), Utah (Grand Junction), Hawái (Hilo), Chile (Calama) y días extra para llegar a Labrador, la isla Devon, Kamchatka, Yakutia o Qaidam.
- **Entradas por sitio:**
  | Sitio | Entrada | Fuente |
  |---|---|---|
  | Meteor Crater | US$ 29 por persona | [meteorcrater.com](https://meteorcrater.com/product/adult/) |
  | Gran Cañón | US$ 35 por vehículo | [NPS](https://home.nps.gov/places/000/south-entrance-station-1.htm) |
  | Craters of the Moon | hasta US$ 20 por vehículo | [NPS](https://www.nps.gov/crmo/planyourvisit/fees.htm) |
  | Hawaiʻi Volcanoes | US$ 30 por vehículo | [NPS](https://www.nps.gov/hawaiivolcanoes/planyourvisit/fees.htm) |
  | Timanfaya | ≈ € 30 por persona | [Viajando por el mundo mundial](https://www.viajandoporelmundomundial.com/visitar-el-parque-nacional-de-timanfaya-lanzarote/) |
  | Reserva Eduardo Avaroa | Bs 150 por persona | [Komoot](https://www.komoot.com/highlight/6106943) |

  Las tarifas por vehículo se dividen entre 3 personas.
- **Viático máximo por departamento en Bolivia:** La Paz US$ 238, Potosí US$ 152, resto US$ 130 ([Departamento de Estado](https://allowances.state.gov/web920/per_diem_action.asp?MenuHide=1&CountryCode=1040)). Los 2 días de aclimatación se cobran al valor de La Paz.
- **Transporte local fuera de Bolivia:** alquiler de vehículo, estimado en US$ 25–150 por persona y día según la región. Es una estimación nuestra.

**Por qué los sitios de Arizona siguen parecidos**

Cinder Lake, SP Mountain, Lava River Cave, Meteor Crater y el Gran Cañón están a menos de 2 horas del mismo aeropuerto y tienen entrenamientos cortos. De verdad cuestan casi lo mismo: se diferencian en la entrada y en los días de trabajo.

No se pudieron consultar los viáticos oficiales por ciudad fuera de Bolivia, porque el sistema de GSA no respondía y el sitio del Departamento de Defensa no permitió el acceso. Esos valores siguen siendo estimaciones por región.
