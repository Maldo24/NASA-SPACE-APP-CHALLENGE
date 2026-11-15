// Entrenamientos posibles en el análogo (tarea 3, datos: Miguel).
// Datos: supabase/seed/08_entrenamientos.sql (y 09 para análogos nuevos).
// Se muestra en la página de detalle del análogo (AnalogDetailPage), ya traducido.
import { useI18n } from '../i18n/I18nProvider'
import type { AnalogTraining } from '../types/domain'

export default function AnalogTrainings({ trainings }: { trainings: AnalogTraining[] }) {
  const { t } = useI18n()
  return (
    <section className="detail-section" aria-labelledby="trainings-heading">
      <h3 id="trainings-heading">{t.trainings.title}</h3>
      {trainings.length === 0 ? (
        <p className="item-pending">{t.trainings.pending}</p>
      ) : (
        <ul className="training-list">
          {trainings.map((tr, i) => (
            <li key={i}>
              <span className="training-audience">{t.audiences[tr.audience]}</span>
              <p>{tr.activity}</p>
              <p><strong>{t.trainings.measures}</strong> {tr.measures}</p>
              {tr.restrictions && <p><strong>{t.trainings.restrictions}</strong> {tr.restrictions}</p>}
              {tr.source && (
                <a className="item-source" href={tr.source} target="_blank" rel="noopener noreferrer">
                  {t.trainings.source} <span aria-hidden="true">↗</span>
                  <span className="sr-only"> {t.newTab}</span>
                </a>
              )}
            </li>
          ))}
        </ul>
      )}
    </section>
  )
}
