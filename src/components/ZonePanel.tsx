import { useEffect, useId, useState } from 'react'
import CategoryTabs from './CategoryTabs'
import AnalogCard from './AnalogCard'
import ZoneFacts from './ZoneFacts'
import { CATEGORIES, CATEGORY_KEYS, type Category } from '../config/categories'
import { emptyAnalogsByCategory, getAnalogsForZone } from '../lib/data'
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

interface ZonePanelProps {
  zone: ZoneSummary | null
  initialCategory?: Category
  onCategoryChange?: (category: Category) => void
}

export default function ZonePanel({ zone, initialCategory, onCategoryChange }: ZonePanelProps) {
  const headingId = useId()
  const grouped = useGroupedAnalogs(zone?.id)

  if (!zone) {
    return (
      <aside className="zone-panel zone-panel-welcome" aria-labelledby={headingId}>
        <div className="panel-kicker"><span className="status-dot" /> Explorador planetario</div>
        <div className="welcome-orbit" aria-hidden="true">
          <svg viewBox="0 0 240 200" fill="none">
            <ellipse cx="120" cy="100" rx="108" ry="38" transform="rotate(-28 120 100)" />
            <circle cx="120" cy="100" r="62" />
            <path d="M67 69c35 18 68 18 106 0M59 100h122M67 131c35-18 68-18 106 0M120 38c-31 32-31 92 0 124M120 38c31 32 31 92 0 124" />
            <circle className="orbit-point" cx="209" cy="57" r="6" />
          </svg>
        </div>
        <p className="eyebrow">Luna · Marte · Tierra</p>
        <h2 id={headingId}>Otros mundos,<br /><span>terrenos en común.</span></h2>
        <p className="welcome-description">Descubre qué lugares de la Tierra ayudan a estudiar y explorar la Luna y Marte.</p>
        <ol className="explorer-steps">
          <li><span aria-hidden="true">01</span><div><strong>Elige un mundo</strong><p>Usa el selector de Luna y Marte.</p></div></li>
          <li><span aria-hidden="true">02</span><div><strong>Selecciona una zona</strong><p>Toca un área delimitada en el mapa.</p></div></li>
          <li><span aria-hidden="true">03</span><div><strong>Compara sus análogos</strong><p>Explora relieve, minerales, ambiente y operaciones.</p></div></li>
        </ol>
        <p className="science-note">Cada análogo comparte aspectos concretos. Ningún lugar terrestre reproduce por completo otro mundo.</p>
      </aside>
    )
  }

  if (!grouped) {
    return (
      <aside className="zone-panel" aria-busy="true" aria-labelledby={headingId}>
        <header className="zone-heading">
          <div className="panel-kicker"><span className="status-dot" /> Zona seleccionada</div>
          <p className="zone-type">{zone.zoneType}</p>
          <h2 id={headingId}>{zone.name}</h2>
          <p className="zone-description">{zone.description}</p>
        </header>
        <p className="muted" role="status">Cargando análogos…</p>
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
  const idPrefix = useId()
  const [category, setCategory] = useState<Category>(
    () => initialCategory ?? CATEGORY_KEYS.find((key) => (grouped[key]?.length ?? 0) > 0) ?? 'geomorphological',
  )
  const properties = zone
  const total = CATEGORY_KEYS.reduce((sum, key) => sum + (grouped[key]?.length ?? 0), 0)

  return (
    <aside className="zone-panel" aria-labelledby={`${idPrefix}-heading`}>
      <header className="zone-heading">
        <div className="panel-kicker"><span className="status-dot" /> Zona seleccionada</div>
        <p className="zone-type">{properties.zoneType}</p>
        <h2 id={`${idPrefix}-heading`}>{properties.name}</h2>
        <p className="zone-description">{properties.description}</p>
        <ZoneFacts zone={properties} />
        <div className="zone-summary"><span><strong>{total}</strong> {total === 1 ? 'análogo terrestre' : 'análogos terrestres'}</span><span>4 categorías</span></div>
      </header>
      <CategoryTabs active={category} counts={grouped} onChange={(nextCategory) => {
        setCategory(nextCategory)
        onCategoryChange?.(nextCategory)
      }} idPrefix={idPrefix} />
      {CATEGORY_KEYS.map((key) => (
        <section key={key} id={`${idPrefix}-panel-${key}`} role="tabpanel"
          aria-labelledby={`${idPrefix}-tab-${key}`} tabIndex={0} hidden={category !== key}>
          {category === key && <>
            <div className="category-intro"><h3>{CATEGORIES[key].label}</h3><p>{CATEGORIES[key].description}</p></div>
            {(grouped[key]?.length ?? 0) === 0 ? (
              <div className="empty-category" role="status">
                <span className="empty-symbol" aria-hidden="true">⌁</span>
                <h3>Aún no hay análogos en esta categoría</h3>
                <p>Prueba otra pestaña para explorar los lugares disponibles para esta zona.</p>
              </div>
            ) : grouped[key]?.map((analog) => <AnalogCard key={analog.id} analog={analog} zone={zone} />)}
          </>}
        </section>
      ))}
      <p className="science-note">Las semejanzas son parciales. Consulta la fuente de cada lugar para conocer su alcance.</p>
    </aside>
  )
}
