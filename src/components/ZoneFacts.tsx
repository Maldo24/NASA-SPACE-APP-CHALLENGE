// Ficha completa de una zona de la Luna o de Marte (tarea 2, datos: Santiago).
// Datos: supabase/seed/07_zonas.sql. Recibe la zona ya traducida.
import { useI18n } from '../i18n/I18nProvider'
import type { Zone } from '../types/domain'

const SECTIONS = ['geology', 'environment', 'exploration', 'importance'] as const

export default function ZoneFacts({ zone }: { zone: Zone }) {
  const { t } = useI18n()
  const filled = SECTIONS.filter((key) => zone[key])

  if (filled.length === 0 && zone.sources.length === 0) {
    return <p className="item-pending">{t.zoneFacts.pending}</p>
  }

  return (
    <details className="zone-facts">
      <summary>{t.zoneFacts.summary}</summary>
      <dl>
        {filled.map((key) => (
          <div key={key}>
            <dt>{t.zoneFacts[key]}</dt>
            <dd>{zone[key]}</dd>
          </div>
        ))}
      </dl>
      {zone.sources.length > 0 && (
        <p className="zone-facts-sources">
          {t.zoneFacts.sources}{' '}
          {zone.sources.map((url, i) => (
            <a key={url} href={url} target="_blank" rel="noopener noreferrer">
              [{i + 1}]<span className="sr-only"> {t.newTab}</span>
            </a>
          ))}
        </p>
      )}
    </details>
  )
}
