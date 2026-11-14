// Persona A. Mapa de la Luna (ruta /luna).
import BasePlanetMap, { type PlanetMapProps } from './BasePlanetMap.tsx'

export default function MoonMap(props: PlanetMapProps) {
  return <BasePlanetMap body="moon" {...props} />
}
