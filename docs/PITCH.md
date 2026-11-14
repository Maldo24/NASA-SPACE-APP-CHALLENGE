# Pitch — Análogos Planetarios

Duración objetivo: **3 minutos**. Una persona habla y otra maneja la demo.
Las afirmaciones científicas siguen la sección 12 de `CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md`.

---

## 1. El problema (30 s)

> Antes de mandar personas o rovers a la Luna o a Marte, hay que practicar en la Tierra.
> Para eso existen los **análogos terrestres**: lugares que se parecen a otro mundo en algo concreto.
>
> Pero la información está dispersa en papers, informes y catálogos. Si eres estudiante, docente o
> investigador y te preguntas *"¿qué lugar de la Tierra se parece a este cráter de Marte?"*,
> no hay un lugar simple donde mirar.

## 2. La solución (30 s)

> **Análogos Planetarios** es un mapa interactivo de la Luna y de Marte, con imágenes de NASA Trek.
> Tocas una zona y ves qué tipo de terreno es y sus análogos en la Tierra, en 4 categorías:
>
> - **Geomorfológico:** el relieve se parece.
> - **Mineralógico:** las rocas o minerales se parecen.
> - **Ambiental:** las condiciones extremas se parecen; sirve para estudiar la vida.
> - **Operacional:** sirve para entrenar astronautas y probar rovers, trajes y hábitats.

## 3. Demo (60 s)

1. Abrir **/marte** y tocar **Meridiani Planum**: sulfatos y hematita, donde aterrizó Opportunity.
   - Mineralógico: **Río Tinto**, por sus aguas ácidas con sulfatos de hierro.
   - Ambiental: **Atacama**, por su aridez extrema.
   - Operacional: **MDRS en Utah**.
2. Tocar **Cráter Jezero**: el antiguo lago donde trabaja Perseverance → **Lago Salda** y las
   **lagunas de altura del Licancabur**, estudiadas en el proyecto High-Lakes.
3. Cambiar a **/luna**, tocar **Tycho** → **Meteor Crater**, y luego **Shackleton** en el polo sur
   → **Antártida**.
4. Mostrar una tarjeta: foto, por qué se parece, mini mapa y **enlace a la fuente**.

## 4. Por qué Bolivia importa (30 s)

> Bolivia tiene escenarios muy valiosos: el **Salar de Uyuni** para comparar depósitos salinos,
> las **lagunas de altura** para estudiar habitabilidad, **Torotoro** para entrenar lectura de estratos
> y **Sajama** para probar equipos en frío y pendiente.
>
> Somos honestos con los límites: **ningún lugar de la Tierra reproduce todo Marte**. La altura del
> Altiplano no reproduce la presión marciana, que es de cientos de pascales. Cada análogo sirve para
> una pregunta concreta, y por eso la app explica *en qué* se parece cada lugar.

## 5. Cómo está hecho y qué sigue (30 s)

> React con Leaflet sobre las teselas de NASA Trek, y Supabase como base de datos relacional:
> un análogo se reutiliza en varias zonas, sin duplicar datos. Todo análogo tiene una fuente real,
> o queda marcado como pendiente: no inventamos fuentes.
>
> **Siguiente paso:** más zonas y análogos, mostrar el nivel de respaldo de cada análogo
> (estudiado, propuesto o sugerido) y sumar análogos latinoamericanos.

---

## Frases que NO debemos decir

| No decir | Decir en cambio |
|---|---|
| "Bolivia simula Marte" | "Bolivia reproduce aspectos concretos de Marte" |
| "Las RSL prueban agua líquida en Marte" | No mencionarlas, o "su origen se sigue debatiendo" |
| "Uyuni tiene percloratos como Marte" | "Uyuni es un análogo salino" |
| "Artemis alunizará en 2028" / "ya hay una base lunar" | "Hay una base **planificada** en el polo sur" |
| "La altura del Altiplano equivale a la presión de Marte" | "La altura no reproduce la presión marciana" |
| "Torotoro es como Valles Marineris" | "Torotoro sirve para entrenar lectura de estratos" |

## Preguntas probables del jurado

- **¿De dónde salen los datos?** De una base curada por el equipo. Cada análogo enlaza a su fuente
  (NASA, ESA, publicaciones o referencias generales) y las fuentes que faltan están marcadas como pendientes.
- **¿Los polígonos son exactos?** No: son aproximados, para orientar. Afinarlos es parte del trabajo siguiente.
- **¿Por qué un análogo tiene una sola categoría?** Para el MVP sí. Si un mismo sitio aporta en dos
  categorías (como Haughton), tiene una ficha para cada una.
