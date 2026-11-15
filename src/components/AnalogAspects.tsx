// Qué reproduce el análogo y dónde se rompe, por tipo de analogía (tarea 1, datos: Maldo).
// Datos: supabase/seed/06_limites.sql (y 09 para análogos nuevos).
// Se muestra en la página de detalle del análogo (AnalogDetailPage), ya traducido.
import { CATEGORY_KEYS } from '../config/categories'
import { useI18n } from '../i18n/I18nProvider'
import type { AnalogAspect } from '../types/domain'

export default function AnalogAspects({ aspects }: { aspects: AnalogAspect[] }) {
  const { t } = useI18n()
  const covered = new Set(aspects.map((a) => a.category))
  const notCovered = CATEGORY_KEYS.filter((c) => !covered.has(c))

  return (
    <section className="detail-section" aria-labelledby="aspects-heading">
      <h3 id="aspects-heading">{t.aspects.title}</h3>
      {aspects.length === 0 ? (
        <p className="item-pending">{t.aspects.pending}</p>
      ) : <>
        <ul className="aspect-list">
          {aspects.map((a) => (
            <li key={a.category}>
              <p className="aspect-category">{t.categories[a.category].label}</p>
              <p><span className="aspect-tag covers">{t.aspects.covers}</span> {a.covers}</p>
              <p><span className="aspect-tag breaks">{t.aspects.breaks}</span> {a.breaks}</p>
              {a.source && (
                <a className="item-source" href={a.source} target="_blank" rel="noopener noreferrer">
                  {t.aspects.source} <span aria-hidden="true">↗</span>
                  <span className="sr-only"> {t.newTab}</span>
                </a>
              )}
            </li>
          ))}
        </ul>
        {notCovered.length > 0 && (
          <p className="aspect-none">
            <strong>{t.aspects.notCovered}</strong> {notCovered.map((c) => t.categories[c].label).join(', ')}.
          </p>
        )}
      </>}
    </section>
  )
}
