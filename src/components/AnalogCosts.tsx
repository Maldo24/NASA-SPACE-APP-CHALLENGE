// Persona A. Costo estimado de los entrenamientos del análogo, por astronauta o por rover.
// Cálculo: lib/trainingCosts.ts. Modelo y fuentes: docs/COSTOS-ENTRENAMIENTOS.md.
import { useState } from 'react'
import type { Analog } from '../types/domain'
import { estimateTrainingCost, ROVER_OPERATORS, type CostBreakdown } from '../lib/trainingCosts'

type Unit = 'astronaut' | 'rover'
// Separador de miles con punto también para 4 cifras (es-ES no agrupa "1500").
// Redondeo: a 10 dólares bajo 1.000 (para que se vean las entradas) y a 100 desde ahí.
const round = (n: number) => (n < 1000 ? Math.round(n / 10) * 10 : Math.round(n / 100) * 100)
const money = (n: number) => `US$ ${String(round(n)).replace(/\B(?=(\d{3})+(?!\d))/g, '.')}`
const range = ([lo, hi]: [number, number]) => (round(lo) === round(hi) ? money(lo) : `${money(lo)} – ${money(hi).replace('US$ ', '')}`)
const mid = ([lo, hi]: [number, number]) => (lo + hi) / 2

const PARTS = [
  { key: 'flight', label: 'Pasaje desde Houston', className: 'cost-flight' },
  { key: 'perDiem', label: 'Viáticos y transporte local', className: 'cost-perdiem' },
  { key: 'fees', label: 'Entradas o cuota de la estación', className: 'cost-fees' },
] as const

function Breakdown({ data }: { data: CostBreakdown }) {
  const total = mid(data.total)
  const parts = PARTS.map((p) => ({ ...p, value: mid(data[p.key]) })).filter((p) => p.value > 0)
  return <>
    <dl className="cost-metrics">
      <div><dt>Costo estimado</dt><dd>{range(data.total)}</dd></div>
      <div><dt>Días fuera de casa</dt><dd>{data.daysAway[0] === data.daysAway[1] ? data.daysAway[0] : `${data.daysAway[0]}–${data.daysAway[1]}`}</dd></div>
      <div><dt>Parte del pasaje</dt><dd>{Math.round((100 * mid(data.flight)) / total)} %</dd></div>
    </dl>
    <div className="cost-bar" role="img" aria-label={parts.map((p) => `${p.label}: ${Math.round((100 * p.value) / total)} %`).join(', ')}>
      {parts.map((p) => <span key={p.key} className={p.className} style={{ width: `${(100 * p.value) / total}%` }} />)}
    </div>
    <ul className="cost-legend">
      {parts.map((p) => <li key={p.key}><span className={p.className} aria-hidden="true" />{p.label}: {range(data[p.key])}</li>)}
    </ul>
  </>
}

export default function AnalogCosts({ analog }: { analog: Analog }) {
  const estimate = estimateTrainingCost(analog)
  const [unit, setUnit] = useState<Unit>(estimate.kind === 'field' && !estimate.perAstronaut ? 'rover' : 'astronaut')

  let body
  if (estimate.kind === 'desk') {
    body = <p>Sus entrenamientos se hacen con imágenes, modelos digitales o datos publicados, sin viajar. <strong>Costo directo: casi US$ 0.</strong></p>
  } else if (estimate.kind === 'unknown') {
    body = <p>Requiere logística polar o de difícil acceso. No hay datos públicos para estimar el costo.</p>
  } else if (estimate.kind === 'mission') {
    body = <p>{estimate.text}</p>
  } else {
    const data = unit === 'astronaut' ? estimate.perAstronaut : estimate.perRover
    body = <>
      <div className="cost-toggle" role="group" aria-label="Calcular el costo">
        <button type="button" aria-pressed={unit === 'astronaut'} onClick={() => setUnit('astronaut')}>Por astronauta</button>
        <button type="button" aria-pressed={unit === 'rover'} onClick={() => setUnit('rover')}>Por rover</button>
      </div>
      {data ? <Breakdown data={data} /> : (
        <p className="item-pending">
          {unit === 'rover' ? 'Este análogo no tiene pruebas de rovers en el campo.' : 'Este análogo no tiene entrenamientos de campo para personas; solo de rovers.'}
        </p>
      )}
      <p className="cost-note">
        Viaje desde Houston a {estimate.regionLabel}.
        {data && ` ${data.siteDays[0] === data.siteDays[1] ? data.siteDays[0] : `${data.siteDays[0]}–${data.siteDays[1]}`} días de trabajo en el sitio para hacer todos sus entrenamientos de campo${unit === 'rover' ? ' con rovers' : ''}.`}
        {estimate.notes.map((n) => ` ${n}`).join('')}
        {unit === 'rover' && ` Por rover se supone un equipo de ${ROVER_OPERATORS} operadores; no incluye construir ni enviar el rover.`}
      </p>
    </>
  }

  return (
    <section className="detail-section analog-costs" aria-labelledby="costs-heading">
      <h3 id="costs-heading">Costo estimado de entrenar aquí</h3>
      {body}
      <p className="cost-disclaimer">Estimación de orden de magnitud con viáticos y pasajes públicos de referencia. No incluye sueldos ni seguros: el costo real sería mayor.</p>
    </section>
  )
}
