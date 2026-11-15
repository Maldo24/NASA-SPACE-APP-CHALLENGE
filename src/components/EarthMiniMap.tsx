// Persona A. Mini mapa de la Tierra con la ubicación del análogo.
import { MapContainer, TileLayer, CircleMarker } from 'react-leaflet'

export type EarthMiniMapProps = { lat: number; lon: number }

export default function EarthMiniMap({ lat, lon }: EarthMiniMapProps) {
  return (
    <MapContainer
      className="earth-mini-map"
      center={[lat, lon]}
      zoom={3}
      scrollWheelZoom={false}
      attributionControl={false}
    >
      <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
      <CircleMarker center={[lat, lon]} radius={7} pathOptions={{ color: '#ff6b6b' }} />
    </MapContainer>
  )
}
