import { useEffect, useRef, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import AnalogPhoto from './AnalogPhoto'
import AnalogAspects from './AnalogAspects'
import AnalogTrainings from './AnalogTrainings'
import AnalogCosts from './AnalogCosts'
import EarthMiniMap from './EarthMiniMap.jsx'
import { CATEGORIES } from '../config/categories'
import { getAnalogsForZone, getZone } from '../lib/data'
import type { Analog, BodyId, Category, Zone } from '../types/domain'

interface AnalogDetailPageProps {
  bodyId: BodyId
  onReturnToZone: (zone: Zone, category: Category) => void
}

type DetailState =
  | { status: 'loading' }
  | { status: 'ready'; zone: Zone; analog: Analog }
  | { status: 'not-found' }
  | { status: 'error' }

function externalSource(value: string | null): string | null {
  if (!value) return null
  try {
    const url = new URL(value)
    return ['http:', 'https:'].includes(url.protocol) ? url.href : null
  } catch {
    return null
  }
}

export default function AnalogDetailPage(props: AnalogDetailPageProps) {
  const { zoneId = '', analogId = '' } = useParams()
  return <AnalogDetails key={`${props.bodyId}/${zoneId}/${analogId}`} {...props} zoneId={zoneId} analogId={analogId} />
}

function AnalogDetails({ bodyId, zoneId, analogId, onReturnToZone }: AnalogDetailPageProps & {
  zoneId: string
  analogId: string
}) {
  const [state, setState] = useState<DetailState>({ status: 'loading' })
  const [attempt, setAttempt] = useState(0)
  const headingRef = useRef<HTMLHeadingElement>(null)
  const bodyPath = bodyId === 'moon' ? '/luna' : '/marte'

  useEffect(() => {
    let active = true
    setState({ status: 'loading' })

    Promise.all([getZone(zoneId), getAnalogsForZone(zoneId)])
      .then(([zone, grouped]) => {
        if (!active) return
        const analog = Object.values(grouped).flat().find((item) => item.id === analogId)
        if (!zone || zone.bodyId !== bodyId || !analog) {
          setState({ status: 'not-found' })
          return
        }
        setState({ status: 'ready', zone, analog })
      })
      .catch(() => {
        if (active) setState({ status: 'error' })
      })

    return () => { active = false }
  }, [bodyId, zoneId, analogId, attempt])

  useEffect(() => {
    headingRef.current?.focus({ preventScroll: true })
  }, [state.status])

  if (state.status !== 'ready') {
    return (
      <section className="analog-detail detail-status" aria-busy={state.status === 'loading'}>
        <Link className="detail-back" to={bodyPath}>← Volver al mapa</Link>
        {state.status === 'loading' && <p role="status">Cargando información del análogo…</p>}
        {state.status === 'not-found' && <>
          <h2 ref={headingRef} tabIndex={-1}>Análogo no encontrado</h2>
          <p>Este enlace no corresponde a un análogo de esta zona. Selecciona un lugar desde el mapa.</p>
        </>}
        {state.status === 'error' && <div role="alert">
          <h2 ref={headingRef} tabIndex={-1}>No se pudo cargar la información</h2>
          <p>Revisa tu conexión y vuelve a intentarlo.</p>
          <button className="information-button" type="button" onClick={() => setAttempt((value) => value + 1)}>Reintentar</button>
        </div>}
      </section>
    )
  }

  const { analog, zone } = state
  const source = externalSource(analog.source)
  const hasLocation = Number.isFinite(analog.lat) && Number.isFinite(analog.lon)
    && Math.abs(analog.lat) <= 90 && Math.abs(analog.lon) <= 180

  return (
    <article className="analog-detail" aria-labelledby="analog-detail-heading">
      <Link className="detail-back" to={bodyPath} onClick={() => onReturnToZone(zone, analog.category)}>
        ← Volver a {zone.name}
      </Link>
      <header className="detail-header">
        <p className="detail-category">{CATEGORIES[analog.category].label}</p>
        <h2 id="analog-detail-heading" ref={headingRef} tabIndex={-1}>{analog.name}</h2>
        <p className="detail-context">Análogo de {zone.name} · {bodyId === 'moon' ? 'Luna' : 'Marte'}</p>
      </header>
      <div className="detail-grid">
        <div className="detail-main">
          <AnalogPhoto analog={analog} loading="eager" />
          <section className="detail-section" aria-labelledby="analogy-heading">
            <h3 id="analogy-heading">Por qué se parece</h3>
            <p>{analog.why}</p>
          </section>
          <section className="detail-section" aria-labelledby="categories-heading">
            <h3 id="categories-heading">Analogías que cumple</h3>
            <dl className="detail-categories">
              <div><dt>Principal</dt><dd>{CATEGORIES[analog.category].label}</dd></div>
              {analog.secondaryCategories.length > 0 && <div>
                <dt>También cumple en parte</dt>
                <dd>{analog.secondaryCategories.map((category) => CATEGORIES[category].label).join(', ')}</dd>
              </div>}
            </dl>
          </section>
          <section className="detail-section detail-breaking-point" aria-labelledby="breaking-heading">
            <h3 id="breaking-heading">Punto de quiebre</h3>
            <p>{analog.breakingPoint ?? 'Pendiente de analizar.'}</p>
          </section>
          <AnalogAspects aspects={analog.aspects} />
          <AnalogTrainings trainings={analog.trainings} />
          <AnalogCosts analog={analog} />
        </div>
        <aside className="detail-sidebar" aria-label="Ubicación y fuente del análogo">
          <section className="detail-location" aria-labelledby="location-heading">
            <h3 id="location-heading">Ubicación en la Tierra</h3>
            {hasLocation ? <>
              <p className="detail-coordinates">{analog.lat.toFixed(2)}°, {analog.lon.toFixed(2)}°</p>
              <EarthMiniMap key={analog.id} lat={analog.lat} lon={analog.lon} />
              <a className="map-credit" href="https://www.openstreetmap.org/copyright" target="_blank" rel="noopener noreferrer">© OpenStreetMap contributors</a>
            </> : <p className="muted">Ubicación pendiente de confirmar.</p>}
          </section>
          <section className="detail-source" aria-labelledby="source-heading">
            <h3 id="source-heading">Fuente</h3>
            {source ? (
              <a className="source-link" href={source} target="_blank" rel="noopener noreferrer">
                Consultar fuente <span aria-hidden="true">↗</span>
                <span className="sr-only"> de {analog.name} (abre en otra pestaña)</span>
              </a>
            ) : <p className="source-pending">Fuente pendiente de verificar</p>}
          </section>
        </aside>
      </div>
    </article>
  )
}
