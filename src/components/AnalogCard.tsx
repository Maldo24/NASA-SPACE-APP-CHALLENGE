import { useId } from 'react'
import { Link } from 'react-router-dom'
import AnalogPhoto from './AnalogPhoto'
import type { AnalogData, ZoneSummary } from './ui-types'

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
        <Link className="information-button" to={detailPath} aria-describedby={titleId}>
          Información <span aria-hidden="true">↗</span>
        </Link>
      </div>
    </article>
  )
}
