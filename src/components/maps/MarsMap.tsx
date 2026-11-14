// Persona A. Mapa de Marte (ruta /marte).
import BasePlanetMap, { type PlanetMapProps } from './BasePlanetMap.tsx'

export default function MarsMap(props: PlanetMapProps) {
  return <BasePlanetMap body="mars" {...props} />
}
