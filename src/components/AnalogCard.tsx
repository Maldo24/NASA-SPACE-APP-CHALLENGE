import { useId, useState } from 'react'
import EarthMiniMap from './EarthMiniMap.jsx'
import AnalogAspects from './AnalogAspects'
import AnalogTrainings from './AnalogTrainings'
import { CATEGORIES } from '../config/categories'
import type { AnalogData } from './ui-types'

function externalSource(value: string): string | null {
  try {
    const url = new URL(value)
    return ['http:', 'https:'].includes(url.protocol) ? url.href : null
  } catch {
    return null
  }
}

export default function AnalogCard({ analog }: { analog: AnalogData }) {
  const titleId = useId()
  const [failedImage, setFailedImage] = useState<string | null>(null)
  // image y source llegan en null cuando están pendientes (esquema de Supabase).
  const rawImage = analog.image ?? ''
  const image = rawImage.startsWith('img/') ? `/${rawImage}` : rawImage
  const showImage = Boolean(image && failedImage !== image)
  const source = analog.source ? externalSource(analog.source) : null
  const hasLocation = Number.isFinite(analog.lat) && Number.isFinite(analog.lon)
    && Math.abs(analog.lat) <= 90 && Math.abs(analog.lon) <= 180

  return (
    <article className="analog-card" aria-labelledby={titleId}>
      <div className="analog-photo">
        {showImage ? (
          <img src={image} alt={`Paisaje de ${analog.name}`} loading="lazy"
            onError={() => setFailedImage(image)} />
        ) : (
          <div className="photo-placeholder">
            <svg viewBox="0 0 120 60" fill="none" aria-hidden="true">
              <circle cx="91" cy="15" r="7" />
              <path d="M4 54 35 15l22 27 15-19 44 31M23 31l12-16 13 16M4 54h112" />
            </svg>
            <span>{analog.image ? 'Fotografía no disponible' : 'Fotografía pendiente'}</span>
          </div>
        )}
        <span className="category-badge">{CATEGORIES[analog.category].short}</span>
      </div>
      <div className="analog-content">
        <p className="eyebrow">Análogo terrestre</p>
        <h3 id={titleId}>{analog.name}</h3>
        <p className="analogy-heading">Por qué se parece</p>
        <p className="analog-reason">{analog.why}</p>
        <p className="analogy-heading">Analogías que cumple</p>
        <p className="analog-reason">
          <strong>{CATEGORIES[analog.category].label}</strong> (la más cercana)
          {analog.secondaryCategories.length > 0 && (
            <>. En parte: {analog.secondaryCategories.map((c) => CATEGORIES[c].label).join(', ')}.</>
          )}
        </p>
        <p className="analogy-heading">Punto de quiebre</p>
        <p className="analog-reason">{analog.breakingPoint ?? 'Pendiente de analizar.'}</p>
        <AnalogAspects aspects={analog.aspects} />
        <AnalogTrainings trainings={analog.trainings} />
        {hasLocation ? (
          <div className="analog-location" role="group" aria-label={`Ubicación de ${analog.name}`}>
            <div className="location-label">
              <span>En la Tierra</span>
              <span>{analog.lat.toFixed(2)}°, {analog.lon.toFixed(2)}°</span>
            </div>
            <EarthMiniMap key={`${analog.id}-${analog.lat}-${analog.lon}`} lat={analog.lat} lon={analog.lon} />
            <a className="map-credit" href="https://www.openstreetmap.org/copyright"
              target="_blank" rel="noopener noreferrer">© OpenStreetMap contributors</a>
          </div>
        ) : <p className="muted">Ubicación pendiente de confirmar.</p>}
        <footer className="analog-footer">
          {source ? (
            <a className="source-link" href={source} target="_blank" rel="noopener noreferrer">
              Consultar fuente <span aria-hidden="true">↗</span>
              <span className="sr-only"> de {analog.name} (abre en otra pestaña)</span>
            </a>
          ) : (
            <span className="source-pending"><span aria-hidden="true">◷</span> Fuente pendiente de verificar</span>
          )}
        </footer>
      </div>
    </article>
  )
}
