import { useEffect, useMemo, useRef, useState, type RefObject } from 'react'
import { Link, useParams } from 'react-router-dom'
import AnalogPhoto from './AnalogPhoto'
import AnalogAspects from './AnalogAspects'
import AnalogTrainings from './AnalogTrainings'
import AnalogCosts from './AnalogCosts'
import EarthMiniMap from './EarthMiniMap.jsx'
import { getAnalogsForZone, getZone } from '../lib/data'
import { useI18n } from '../i18n/I18nProvider'
import { localizeAnalog, localizeZone } from '../i18n/content'
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
  const { t } = useI18n()
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
        <Link className="detail-back" to={bodyPath}>{t.detail.backToMap}</Link>
        {state.status === 'loading' && <p role="status">{t.detail.loading}</p>}
        {state.status === 'not-found' && <>
          <h2 ref={headingRef} tabIndex={-1}>{t.detail.notFoundTitle}</h2>
          <p>{t.detail.notFoundText}</p>
        </>}
        {state.status === 'error' && <div role="alert">
          <h2 ref={headingRef} tabIndex={-1}>{t.detail.errorTitle}</h2>
          <p>{t.detail.errorText}</p>
          <button className="information-button" type="button" onClick={() => setAttempt((value) => value + 1)}>{t.detail.retry}</button>
        </div>}
      </section>
    )
  }

  return <ReadyDetail {...state} bodyId={bodyId} bodyPath={bodyPath} headingRef={headingRef} onReturnToZone={onReturnToZone} />
}

function ReadyDetail({ analog: original, zone: rawZone, bodyId, bodyPath, headingRef, onReturnToZone }: {
  analog: Analog
  zone: Zone
  bodyId: BodyId
  bodyPath: string
  headingRef: RefObject<HTMLHeadingElement>
  onReturnToZone: (zone: Zone, category: Category) => void
}) {
  const { t, lang } = useI18n()
  // Se muestra traducido; los costos usan el original (su cálculo lee el texto en español).
  const analog = useMemo(() => localizeAnalog(original, lang), [original, lang])
  const zone = useMemo(() => localizeZone(rawZone, lang), [rawZone, lang])
  const source = externalSource(analog.source)
  const hasLocation = Number.isFinite(analog.lat) && Number.isFinite(analog.lon)
    && Math.abs(analog.lat) <= 90 && Math.abs(analog.lon) <= 180

  return (
    <article className="analog-detail" aria-labelledby="analog-detail-heading">
      <Link className="detail-back" to={bodyPath} onClick={() => onReturnToZone(rawZone, analog.category)}>
        {t.detail.backTo(zone.name)}
      </Link>
      <header className="detail-header">
        <p className="detail-category">{t.categories[analog.category].label}</p>
        <h2 id="analog-detail-heading" ref={headingRef} tabIndex={-1}>{analog.name}</h2>
        <p className="detail-context">{t.detail.analogOf(zone.name, t.bodies[bodyId])}</p>
      </header>
      <div className="detail-grid">
        <div className="detail-main">
          <AnalogPhoto analog={analog} loading="eager" />
          <section className="detail-section" aria-labelledby="analogy-heading">
            <h3 id="analogy-heading">{t.detail.why}</h3>
            <p>{analog.why}</p>
          </section>
          <section className="detail-section" aria-labelledby="categories-heading">
            <h3 id="categories-heading">{t.detail.categories}</h3>
            <dl className="detail-categories">
              <div><dt>{t.detail.main}</dt><dd>{t.categories[analog.category].label}</dd></div>
              {analog.secondaryCategories.length > 0 && <div>
                <dt>{t.detail.partial}</dt>
                <dd>{analog.secondaryCategories.map((category) => t.categories[category].label).join(', ')}</dd>
              </div>}
            </dl>
          </section>
          <section className="detail-section detail-breaking-point" aria-labelledby="breaking-heading">
            <h3 id="breaking-heading">{t.detail.breakingPoint}</h3>
            <p>{analog.breakingPoint ?? t.detail.pendingAnalysis}</p>
          </section>
          <AnalogAspects aspects={analog.aspects} />
          <AnalogTrainings trainings={analog.trainings} />
          <AnalogCosts analog={original} />
        </div>
        <aside className="detail-sidebar" aria-label={t.detail.sidebar}>
          <section className="detail-location" aria-labelledby="location-heading">
            <h3 id="location-heading">{t.detail.location}</h3>
            {hasLocation ? <>
              <p className="detail-coordinates">{analog.lat.toFixed(2)}°, {analog.lon.toFixed(2)}°</p>
              <EarthMiniMap key={analog.id} lat={analog.lat} lon={analog.lon} />
              <a className="map-credit" href="https://www.openstreetmap.org/copyright" target="_blank" rel="noopener noreferrer">© OpenStreetMap contributors</a>
            </> : <p className="muted">{t.detail.locationPending}</p>}
          </section>
          <section className="detail-source" aria-labelledby="source-heading">
            <h3 id="source-heading">{t.detail.source}</h3>
            {source ? (
              <a className="source-link" href={source} target="_blank" rel="noopener noreferrer">
                {t.detail.sourceLink} <span aria-hidden="true">↗</span>
                <span className="sr-only">{t.detail.sourceOf(analog.name)}</span>
              </a>
            ) : <p className="source-pending">{t.detail.sourcePending}</p>}
          </section>
        </aside>
      </div>
    </article>
  )
}
