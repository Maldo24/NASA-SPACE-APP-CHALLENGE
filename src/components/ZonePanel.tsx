import { useEffect, useId, useMemo, useState } from 'react'
import CategoryTabs from './CategoryTabs'
import AnalogCard from './AnalogCard'
import ZoneFacts from './ZoneFacts'
import { CATEGORY_KEYS, type Category } from '../config/categories'
import { emptyAnalogsByCategory, getAnalogsForZone } from '../lib/data'
import { useI18n, type Lang } from '../i18n/I18nProvider'
import { localizeAnalog, localizeZone } from '../i18n/content'
import { regionRank } from '../lib/analogRegion'
import type { GroupedAnalogs, ZoneSummary } from './ui-types'

// Carga asíncrona de los análogos de la zona. null = cargando.
function useGroupedAnalogs(zoneId: string | undefined) {
  const [state, setState] = useState<{ zoneId: string; grouped: GroupedAnalogs } | null>(null)
  useEffect(() => {
    if (!zoneId) return
    let alive = true
    getAnalogsForZone(zoneId)
      .then((grouped) => { if (alive) setState({ zoneId, grouped }) })
      .catch((err) => {
        console.error(`No se pudieron cargar los análogos de ${zoneId}`, err)
        if (alive) setState({ zoneId, grouped: emptyAnalogsByCategory() })
      })
    return () => { alive = false }
  }, [zoneId])
  // Si el estado es de otra zona, todavía se está cargando la actual.
  return state && state.zoneId === zoneId ? state.grouped : null
}

// Traduce los análogos y los ordena: primero Bolivia, luego Latinoamérica y al final el resto del
// mundo; dentro de cada grupo, por nombre en el idioma actual. La región sale del nombre en español.
function localizeGrouped(grouped: GroupedAnalogs, lang: Lang): GroupedAnalogs {
  const out: GroupedAnalogs = {}
  for (const key of CATEGORY_KEYS) {
    out[key] = (grouped[key] ?? [])
      .map((a) => ({ rank: regionRank(a.name), analog: localizeAnalog(a, lang) }))
      .sort((a, b) => a.rank - b.rank || a.analog.name.localeCompare(b.analog.name, lang))
      .map((x) => x.analog)
  }
  return out
}

interface ZonePanelProps {
  zone: ZoneSummary | null
  initialCategory?: Category
  onCategoryChange?: (category: Category) => void
}

export default function ZonePanel({ zone: rawZone, initialCategory, onCategoryChange }: ZonePanelProps) {
  const { t, lang } = useI18n()
  const headingId = useId()
  const rawGrouped = useGroupedAnalogs(rawZone?.id)
  const zone = useMemo(() => (rawZone ? localizeZone(rawZone, lang) : null), [rawZone, lang])
  const grouped = useMemo(() => (rawGrouped ? localizeGrouped(rawGrouped, lang) : null), [rawGrouped, lang])

  if (!zone) {
    return (
      <aside className="zone-panel zone-panel-welcome" aria-labelledby={headingId}>
        <div className="panel-kicker"><span className="status-dot" /> {t.welcome.kicker}</div>
        <div className="welcome-orbit" aria-hidden="true">
          <svg viewBox="0 0 240 200" fill="none">
            <ellipse cx="120" cy="100" rx="108" ry="38" transform="rotate(-28 120 100)" />
            <circle cx="120" cy="100" r="62" />
            <path d="M67 69c35 18 68 18 106 0M59 100h122M67 131c35-18 68-18 106 0M120 38c-31 32-31 92 0 124M120 38c31 32 31 92 0 124" />
            <circle className="orbit-point" cx="209" cy="57" r="6" />
          </svg>
        </div>
        <p className="eyebrow">{t.welcome.eyebrow}</p>
        <h2 id={headingId}>{t.welcome.title}<br /><span>{t.welcome.titleAccent}</span></h2>
        <p className="welcome-description">{t.welcome.description}</p>
        <ol className="explorer-steps">
          {t.welcome.steps.map((step, i) => (
            <li key={i}><span aria-hidden="true">{String(i + 1).padStart(2, '0')}</span><div><strong>{step.title}</strong><p>{step.text}</p></div></li>
          ))}
        </ol>
        <p className="science-note">{t.welcome.note}</p>
      </aside>
    )
  }

  if (!grouped) {
    return (
      <aside className="zone-panel" aria-busy="true" aria-labelledby={headingId}>
        <header className="zone-heading">
          <div className="panel-kicker"><span className="status-dot" /> {t.panel.selected}</div>
          <p className="zone-type">{zone.zoneType}</p>
          <h2 id={headingId}>{zone.name}</h2>
          <p className="zone-description">{zone.description}</p>
        </header>
        <p className="muted" role="status">{t.panel.loading}</p>
      </aside>
    )
  }

  return <ZoneDetails key={zone.id} zone={zone} grouped={grouped} initialCategory={initialCategory} onCategoryChange={onCategoryChange} />
}

function ZoneDetails({ zone, grouped, initialCategory, onCategoryChange }: {
  zone: ZoneSummary
  grouped: GroupedAnalogs
  initialCategory?: Category
  onCategoryChange?: (category: Category) => void
}) {
  const { t } = useI18n()
  const idPrefix = useId()
  const [category, setCategory] = useState<Category>(
    () => initialCategory ?? CATEGORY_KEYS.find((key) => (grouped[key]?.length ?? 0) > 0) ?? 'geomorphological',
  )
  const total = CATEGORY_KEYS.reduce((sum, key) => sum + (grouped[key]?.length ?? 0), 0)

  return (
    <aside className="zone-panel" aria-labelledby={`${idPrefix}-heading`}>
      <header className="zone-heading">
        <div className="panel-kicker"><span className="status-dot" /> {t.panel.selected}</div>
        <p className="zone-type">{zone.zoneType}</p>
        <h2 id={`${idPrefix}-heading`}>{zone.name}</h2>
        <p className="zone-description">{zone.description}</p>
        <ZoneFacts zone={zone} />
        <div className="zone-summary"><span><strong>{total}</strong> {t.panel.analogCount(total)}</span><span>{t.panel.categoryCount}</span></div>
      </header>
      <CategoryTabs active={category} counts={grouped} onChange={(nextCategory) => {
        setCategory(nextCategory)
        onCategoryChange?.(nextCategory)
      }} idPrefix={idPrefix} />
      {CATEGORY_KEYS.map((key) => (
        <section key={key} id={`${idPrefix}-panel-${key}`} role="tabpanel"
          aria-labelledby={`${idPrefix}-tab-${key}`} tabIndex={0} hidden={category !== key}>
          {category === key && <>
            <div className="category-intro"><h3>{t.categories[key].label}</h3><p>{t.categories[key].description}</p></div>
            {(grouped[key]?.length ?? 0) === 0 ? (
              <div className="empty-category" role="status">
                <span className="empty-symbol" aria-hidden="true">⌁</span>
                <h3>{t.panel.emptyTitle}</h3>
                <p>{t.panel.emptyText}</p>
              </div>
            ) : grouped[key]?.map((analog) => <AnalogCard key={analog.id} analog={analog} zone={zone} />)}
          </>}
        </section>
      ))}
      <p className="science-note">{t.panel.note}</p>
    </aside>
  )
}
