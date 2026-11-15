// Persona A. Costo estimado de los entrenamientos del análogo, por astronauta o por rover.
// Cálculo: lib/trainingCosts.ts. Modelo y fuentes: docs/COSTOS-ENTRENAMIENTOS.md.
// Importante: recibe el análogo ORIGINAL (en español). El cálculo lee el texto en español de los
// entrenamientos; la traducción solo cambia lo que se muestra.
import { useState } from 'react'
import type { Analog } from '../types/domain'
import { estimateTrainingCost, ROVER_OPERATORS, type CostBreakdown } from '../lib/trainingCosts'
import { useI18n, type Lang } from '../i18n/I18nProvider'
import type { UiStrings } from '../i18n/strings'

type Unit = 'astronaut' | 'rover'
// Redondeo: a 10 dólares bajo 1.000 (para que se vean las entradas) y a 100 desde ahí.
const round = (n: number) => (n < 1000 ? Math.round(n / 10) * 10 : Math.round(n / 100) * 100)
// Separador de miles: punto en español (también para 4 cifras: es-ES no agrupa "1500") y coma en inglés.
const group = (n: number, lang: Lang) => String(round(n)).replace(/\B(?=(\d{3})+(?!\d))/g, lang === 'es' ? '.' : ',')
const money = (n: number, lang: Lang) => `US$ ${group(n, lang)}`
const range = ([lo, hi]: [number, number], lang: Lang) =>
  (round(lo) === round(hi) ? money(lo, lang) : `${money(lo, lang)} – ${group(hi, lang)}`)
const mid = ([lo, hi]: [number, number]) => (lo + hi) / 2
const days = ([lo, hi]: [number, number]) => (lo === hi ? String(lo) : `${lo}–${hi}`)

const PARTS = [
  { key: 'flight', className: 'cost-flight' },
  { key: 'perDiem', className: 'cost-perdiem' },
  { key: 'fees', className: 'cost-fees' },
] as const

function Breakdown({ data, t, lang }: { data: CostBreakdown; t: UiStrings['costs']; lang: Lang }) {
  const total = mid(data.total)
  const parts = PARTS.map((p) => ({ ...p, label: t.parts[p.key], value: mid(data[p.key]) })).filter((p) => p.value > 0)
  return <>
    <dl className="cost-metrics">
      <div><dt>{t.total}</dt><dd>{range(data.total, lang)}</dd></div>
      <div><dt>{t.daysAway}</dt><dd>{days(data.daysAway)}</dd></div>
      <div><dt>{t.flightShare}</dt><dd>{Math.round((100 * mid(data.flight)) / total)} %</dd></div>
    </dl>
    <div className="cost-bar" role="img" aria-label={parts.map((p) => `${p.label}: ${Math.round((100 * p.value) / total)} %`).join(', ')}>
      {parts.map((p) => <span key={p.key} className={p.className} style={{ width: `${(100 * p.value) / total}%` }} />)}
    </div>
    <ul className="cost-legend">
      {parts.map((p) => <li key={p.key}><span className={p.className} aria-hidden="true" />{p.label}: {range(data[p.key], lang)}</li>)}
    </ul>
  </>
}

export default function AnalogCosts({ analog }: { analog: Analog }) {
  const { t: { costs: t }, lang } = useI18n()
  const estimate = estimateTrainingCost(analog)
  const [unit, setUnit] = useState<Unit>(estimate.kind === 'field' && !estimate.perAstronaut ? 'rover' : 'astronaut')

  let body
  if (estimate.kind === 'desk') {
    body = <p>{t.desk} <strong>{t.deskCost}</strong></p>
  } else if (estimate.kind === 'unknown') {
    body = <p>{t.unknown}</p>
  } else if (estimate.kind === 'mission') {
    body = <p>{estimate.text[lang]}</p>
  } else {
    const data = unit === 'astronaut' ? estimate.perAstronaut : estimate.perRover
    body = <>
      <div className="cost-toggle" role="group" aria-label={t.unitGroup}>
        <button type="button" aria-pressed={unit === 'astronaut'} onClick={() => setUnit('astronaut')}>{t.perAstronaut}</button>
        <button type="button" aria-pressed={unit === 'rover'} onClick={() => setUnit('rover')}>{t.perRover}</button>
      </div>
      {data ? <Breakdown data={data} t={t} lang={lang} /> : (
        <p className="item-pending">{unit === 'rover' ? t.noRover : t.noPeople}</p>
      )}
      <p className="cost-note">
        {t.travelFrom(estimate.regionLabel[lang])}
        {data && ` ${t.siteDays(days(data.siteDays), unit === 'rover')}`}
        {estimate.notes.map((n) => ` ${n[lang]}`).join('')}
        {unit === 'rover' && ` ${t.roverTeam(ROVER_OPERATORS)}`}
      </p>
    </>
  }

  return (
    <section className="detail-section analog-costs" aria-labelledby="costs-heading">
      <h3 id="costs-heading">{t.title}</h3>
      {body}
      <p className="cost-disclaimer">{t.disclaimer}</p>
    </section>
  )
}
