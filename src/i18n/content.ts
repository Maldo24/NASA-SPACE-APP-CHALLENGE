// Traducción del CONTENIDO (zonas y análogos) al inglés.
//
// Los datos originales están en español (supabase/seed/ -> src/data/*.json) y no se tocan:
// la traducción se aplica encima, campo por campo, solo al mostrarlos. Si falta un campo en
// inglés se muestra el español. Así el cálculo de costos (lib/trainingCosts.ts), que lee el
// texto en español, no cambia con el idioma.
//
// Archivos de traducción: src/i18n/content/en/zones.json y analogs.json, por id.
// Revisar faltantes o desactualizados: npm run i18n:check
import type { Analog, AnalogAspect, AnalogTraining, Category, Zone } from '../types/domain'
import type { Lang } from './I18nProvider'
import zonesEn from './content/en/zones.json'
import analogsEn from './content/en/analogs.json'

type Text = string | undefined

export interface ZoneTranslation {
  name?: Text; zoneType?: Text; description?: Text
  geology?: Text; environment?: Text; exploration?: Text; importance?: Text
}

export interface AnalogTranslation {
  name?: Text; why?: Text; breakingPoint?: Text
  aspects?: Partial<Record<Category, { covers?: Text; breaks?: Text }>>
  /** En el mismo orden que los entrenamientos del análogo (por `position`). */
  trainings?: { activity?: Text; measures?: Text; restrictions?: Text }[]
}

// `_src` es la huella del texto en español que se tradujo (la usa npm run i18n:check).
const ZONES = zonesEn as Record<string, ZoneTranslation & { _src?: string }>
const ANALOGS = analogsEn as Record<string, AnalogTranslation & { _src?: string }>

const pick = (translated: Text, original: string): string => (translated?.trim() ? translated : original)
const pickNullable = (translated: Text, original: string | null): string | null =>
  original === null ? null : pick(translated, original)

export function localizeZone<T extends Zone>(zone: T, lang: Lang): T {
  const tr = lang === 'en' ? ZONES[zone.id] : undefined
  if (!tr) return zone
  return {
    ...zone,
    name: pick(tr.name, zone.name),
    zoneType: pick(tr.zoneType, zone.zoneType),
    description: pick(tr.description, zone.description),
    geology: pickNullable(tr.geology, zone.geology),
    environment: pickNullable(tr.environment, zone.environment),
    exploration: pickNullable(tr.exploration, zone.exploration),
    importance: pickNullable(tr.importance, zone.importance),
  }
}

export function localizeAnalog(analog: Analog, lang: Lang): Analog {
  const tr = lang === 'en' ? ANALOGS[analog.id] : undefined
  if (!tr) return analog
  const aspects: AnalogAspect[] = analog.aspects.map((a) => {
    const t = tr.aspects?.[a.category]
    return t ? { ...a, covers: pick(t.covers, a.covers), breaks: pick(t.breaks, a.breaks) } : a
  })
  const trainings: AnalogTraining[] = analog.trainings.map((t, i) => {
    const x = tr.trainings?.[i]
    return x ? {
      ...t,
      activity: pick(x.activity, t.activity),
      measures: pick(x.measures, t.measures),
      restrictions: pickNullable(x.restrictions, t.restrictions),
    } : t
  })
  return {
    ...analog,
    name: pick(tr.name, analog.name),
    why: pick(tr.why, analog.why),
    breakingPoint: pickNullable(tr.breakingPoint, analog.breakingPoint),
    aspects,
    trainings,
  }
}
