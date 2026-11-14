// Persona 2. Tarjeta de un análogo terrestre.
import EarthMiniMap from './EarthMiniMap.jsx'

export default function AnalogCard({ analog }) {
  return (
    <article className="analog-card">
      <h3>{analog.name}</h3>
      {analog.image && <img src={analog.image} alt={analog.name} />}
      <p>{analog.why}</p>
      <EarthMiniMap lat={analog.lat} lon={analog.lon} />
      {analog.source && <a href={analog.source} target="_blank" rel="noreferrer">Fuente</a>}
    </article>
  )
}
