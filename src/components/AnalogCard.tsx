import { useId } from 'react'
import { Link } from 'react-router-dom'
import AnalogPhoto from './AnalogPhoto'
import { useI18n } from '../i18n/I18nProvider'
import type { AnalogData, ZoneSummary } from './ui-types'

interface AnalogCardProps {
  /** Análogo ya traducido (ZonePanel lo traduce). */
  analog: AnalogData
  zone: Pick<ZoneSummary, 'id' | 'bodyId'>
}

export default function AnalogCard({ analog, zone }: AnalogCardProps) {
  const { t } = useI18n()
  const titleId = useId()
  const bodyPath = zone.bodyId === 'moon' ? '/luna' : '/marte'
  const detailPath = `${bodyPath}/analogos/${encodeURIComponent(zone.id)}/${encodeURIComponent(analog.id)}`

  return (
    <article className="analog-card" aria-labelledby={titleId}>
      <AnalogPhoto analog={analog} />
      <div className="analog-content">
        <h3 id={titleId}>{analog.name}</h3>
        <Link className="information-button" to={detailPath} aria-describedby={titleId}>
          {t.card.info} <span aria-hidden="true">↗</span>
        </Link>
      </div>
    </article>
  )
}
