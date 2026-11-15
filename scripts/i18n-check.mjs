// Revisa la traducción al inglés del contenido (zonas y análogos).
//
//   npm run i18n:check            lista lo que falta traducir y lo que quedó desactualizado
//   npm run i18n:check -- --stamp marca lo traducido como al día con el español actual
//
// "Desactualizado" = alguien cambió el texto en español (seed SQL -> src/data/*.json) después de
// traducirlo. Cada entrada en inglés guarda en `_src` una huella del español que se tradujo.
// Usar --stamp SOLO después de revisar y actualizar esas traducciones.
import { createHash } from 'node:crypto'
import { readFileSync, writeFileSync } from 'node:fs'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

const ROOT = join(dirname(fileURLToPath(import.meta.url)), '..')
const read = (p) => JSON.parse(readFileSync(join(ROOT, p), 'utf8'))
const ZONES_EN = 'src/i18n/content/en/zones.json'
const ANALOGS_EN = 'src/i18n/content/en/analogs.json'

const zones = [...read('src/data/zones-moon.json').features, ...read('src/data/zones-mars.json').features].map((f) => f.properties)
const analogs = read('src/data/analogs.json')
const zonesEn = read(ZONES_EN)
const analogsEn = read(ANALOGS_EN)

const hash = (value) => createHash('sha1').update(JSON.stringify(value)).digest('hex').slice(0, 10)
const ZONE_FIELDS = ['name', 'zoneType', 'description', 'geology', 'environment', 'exploration', 'importance']
const zoneSource = (z) => ZONE_FIELDS.map((k) => z[k] ?? null)
const analogSource = (a) => [
  a.name, a.why, a.breaking_point ?? null,
  a.aspects.map((s) => [s.category, s.covers, s.breaks]),
  a.trainings.map((t) => [t.activity, t.measures, t.restrictions ?? null]),
]
const filled = (v) => typeof v === 'string' && v.trim() !== ''

const missing = []
const stale = []
const orphans = []

for (const z of zones) {
  const tr = zonesEn[z.id]
  if (!tr) { missing.push(`zona ${z.id}: sin traducir`); continue }
  for (const k of ZONE_FIELDS) if (filled(z[k]) && !filled(tr[k])) missing.push(`zona ${z.id}: falta "${k}"`)
  if (tr._src && tr._src !== hash(zoneSource(z))) stale.push(`zona ${z.id}`)
}

for (const a of analogs) {
  const tr = analogsEn[a.id]
  if (!tr) { missing.push(`análogo ${a.id}: sin traducir`); continue }
  for (const [k, src] of [['name', a.name], ['why', a.why], ['breakingPoint', a.breaking_point]]) {
    if (filled(src) && !filled(tr[k])) missing.push(`análogo ${a.id}: falta "${k}"`)
  }
  for (const s of a.aspects) {
    const t = tr.aspects?.[s.category]
    if (!filled(t?.covers) || !filled(t?.breaks)) missing.push(`análogo ${a.id}: falta el límite "${s.category}"`)
  }
  if ((tr.trainings ?? []).length !== a.trainings.length) {
    missing.push(`análogo ${a.id}: ${a.trainings.length} entrenamientos en español, ${(tr.trainings ?? []).length} en inglés`)
  } else {
    a.trainings.forEach((t, i) => {
      const x = tr.trainings[i]
      if (!filled(x.activity) || !filled(x.measures) || (filled(t.restrictions) && !filled(x.restrictions))) {
        missing.push(`análogo ${a.id}: entrenamiento ${i + 1} incompleto`)
      }
    })
  }
  if (tr._src && tr._src !== hash(analogSource(a))) stale.push(`análogo ${a.id}`)
}

for (const id of Object.keys(zonesEn)) if (!zones.some((z) => z.id === id)) orphans.push(`zona ${id}`)
for (const id of Object.keys(analogsEn)) if (!analogs.some((a) => a.id === id)) orphans.push(`análogo ${id}`)

if (process.argv.includes('--stamp')) {
  for (const z of zones) if (zonesEn[z.id]) zonesEn[z.id] = { _src: hash(zoneSource(z)), ...withoutSrc(zonesEn[z.id]) }
  for (const a of analogs) if (analogsEn[a.id]) analogsEn[a.id] = { _src: hash(analogSource(a)), ...withoutSrc(analogsEn[a.id]) }
  writeFileSync(join(ROOT, ZONES_EN), JSON.stringify(sortKeys(zonesEn), null, 2) + '\n')
  writeFileSync(join(ROOT, ANALOGS_EN), JSON.stringify(sortKeys(analogsEn), null, 2) + '\n')
  console.log('Huellas actualizadas: lo traducido queda marcado como al día con el español actual.')
}

function withoutSrc(o) { const { _src, ...rest } = o; return rest }
function sortKeys(o) { return Object.fromEntries(Object.keys(o).sort().map((k) => [k, o[k]])) }

const total = zones.length + analogs.length
const done = zones.filter((z) => zonesEn[z.id]).length + analogs.filter((a) => analogsEn[a.id]).length
console.log(`Traducción al inglés: ${done}/${total} fichas (${zones.length} zonas, ${analogs.length} análogos).`)
const show = (title, list) => { if (list.length) console.log(`\n${title} (${list.length}):\n  ${list.join('\n  ')}`) }
show('Falta traducir', missing)
show('Desactualizado: el español cambió después de traducir', stale)
show('Sobra: el id ya no existe en los datos', orphans)
if (!missing.length && !stale.length && !orphans.length) console.log('Todo traducido y al día.')
process.exitCode = missing.length || stale.length || orphans.length ? 1 : 0
