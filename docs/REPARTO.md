# Reparto: profundizar análogos y zonas

Tres tareas en paralelo, sin tocar los mismos archivos. La estructura (Paso 0) ya está hecha:
la base, los tipos, `data.ts` y las secciones de la app existen y están vacías. Cada persona solo llena datos en su archivo.

## Antes de empezar

```bash
git checkout main && git pull
npm install                      # siempre después de un pull
git checkout -b <tu-rama>        # limites, zonas o entrenamientos
```

## Quién hace qué

### Maldo — Límites de cada análogo
**Archivo:** `supabase/seed/06_limites.sql` (tabla `analog_aspects`)

Para cada uno de los **51 análogos** y para cada tipo de analogía que cumple (la principal y las de "en parte"):
- **Reproduce:** qué cubre el sitio en esa categoría.
- **Se rompe:** dónde deja de servir la analogía.

Las categorías sin fila aparecen en la app como **"No cubre"**. Ambiental = condiciones para la vida;
operacional = lo que se puede practicar ahí. El archivo trae un ejemplo y una checklist con las categorías de cada análogo.

### Santiago — Zonas de la Luna y Marte
**Archivo:** `supabase/seed/07_zonas.sql` (columnas nuevas de `zones` + zonas nuevas)

1. Completar la ficha de las **17 zonas**: geología, ambiente, exploración, por qué interesa y fuentes.
2. Agregar **zonas nuevas**, sobre todo de la Luna (meta: 4 lunares y 2–3 marcianas), con ficha completa
   y relacionadas con análogos existentes.
3. **Primero que nada:** anunciar en el grupo los ids de las zonas nuevas (`moon-…`), porque Miguel los necesita.

### Miguel — Entrenamientos y análogos nuevos
**Archivos:** `supabase/seed/08_entrenamientos.sql` (tabla `analog_trainings`) y `supabase/seed/09_analogos_nuevos.sql`

1. De 1 a 3 entrenamientos por cada uno de los **51 análogos**: para quién (astronautas, rovers, trajes,
   hábitats o ciencia), qué se practica, qué se mide y restricciones. Base para Bolivia: `tmp/lectura/F2.txt`.
2. **Análogos nuevos** (meta: 6–10, prioridad Luna), cada uno completo en el archivo 09: datos, límites,
   entrenamientos y zonas.

## Dónde se ve cada cosa en la app

| Dato | Dónde aparece |
|---|---|
| Ficha de zona (Santiago) | Panel de la zona → "Ficha de la zona" (desplegable) |
| Límites (Maldo) | Tarjeta del análogo → botón "Información" → sección "Qué cubre y dónde se rompe" |
| Entrenamientos (Miguel) | Tarjeta del análogo → botón "Información" → sección "Entrenamiento posible" |

Mientras no hay datos, cada sección muestra "pendiente".

## Cómo probar lo que escribiste

```bash
bash supabase/seed/exportar-json.sh   # carga el SQL, valida y regenera src/data/*.json
npm run dev                           # y abre /luna o /marte
```

El script muestra el avance (`límites 12/51 | fichas de zona 3/17 | entrenamientos 8/51`) y avisa si:
- un límite está en una categoría que el análogo no tiene,
- un análogo no está en ninguna zona,
- una zona no tiene análogos.

La base rechaza: categorías o públicos que no existen, textos vacíos, enlaces que no empiezan con `http`
y análogos o zonas que no existen. Si el script falla, el mensaje dice qué fila está mal.

Necesita **podman o docker**. Quien no lo tenga le pide a Maldo que lo corra.

## Reglas para no pisarse

| Archivo | Dueño |
|---|---|
| `06_limites.sql` | Maldo |
| `07_zonas.sql` | Santiago |
| `08_entrenamientos.sql`, `09_analogos_nuevos.sql` | Miguel |
| `01`–`05`, migraciones, `exportar-json.sh` | Nadie los edita sin avisar |
| Componentes y `data.ts` | Nadie los necesita tocar para esta tarea |
| `src/data/*.json` | Generados: nunca se editan a mano |

- **Conflicto en `src/data/*.json` al unir un PR:** no se resuelve a mano. Se acepta cualquier versión y se
  vuelve a correr `bash supabase/seed/exportar-json.sh`.
- **Orden de carga:** 06 → 07 → 08 → 09. Las zonas nuevas (07) existen antes que los análogos nuevos (09).
- Cada uno en su rama y con su PR. Revisión cruzada: A revisa a B, B a C y C a A.

## Reglas de contenido

- Nada sin fuente real. Si no hay fuente, `source` en `null` y se dice en el texto.
- Respetar la sección 12 de `CONTEXTO_EXPLORACION_ESPACIAL_BOLIVIA.md`: la altura no reproduce la presión
  de Marte, las RSL no prueban agua líquida, no hay percloratos en Uyuni sin análisis, el calendario de
  Artemis no está verificado.
- Los sitios bolivianos mantienen su nivel de respaldo de F4: estudiado, propuesto o sugerido.
- Los entrenamientos son **posibles o propuestos**; no afirmar que ya se hicieron si la fuente no lo dice.
- Lenguaje sencillo: lo lee un estudiante, no un especialista.
