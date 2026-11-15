import { useId, useState } from 'react'
import EarthMiniMap from './EarthMiniMap.jsx'
import AnalogAspects from './AnalogAspects'
import AnalogTrainings from './AnalogTrainings'
import { CATEGORIES } from '../config/categories'
import type { AnalogData } from './ui-types'

interface AnalogCardProps {
  analog: AnalogData
  zone: Pick<ZoneSummary, 'id' | 'bodyId'>
}

export default function AnalogCard({ analog, zone }: AnalogCardProps) {
  const titleId = useId()
  const bodyPath = zone.bodyId === 'moon' ? '/luna' : '/marte'
  const detailPath = `${bodyPath}/analogos/${encodeURIComponent(zone.id)}/${encodeURIComponent(analog.id)}`

  return (
    <article className="analog-card" aria-labelledby={titleId}>
      <AnalogPhoto analog={analog} />
      <div className="analog-content">
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
