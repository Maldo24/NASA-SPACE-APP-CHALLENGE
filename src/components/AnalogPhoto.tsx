import { useState } from 'react'
import type { Analog } from '../types/domain'

interface AnalogPhotoProps {
  analog: Pick<Analog, 'name' | 'image'>
  loading?: 'eager' | 'lazy'
}

export default function AnalogPhoto({ analog, loading = 'lazy' }: AnalogPhotoProps) {
  const [failedImage, setFailedImage] = useState<string | null>(null)
  const rawImage = analog.image ?? ''
  const image = rawImage.startsWith('img/') ? `/${rawImage}` : rawImage
  const showImage = Boolean(image && failedImage !== image)

  return (
    <div className="analog-photo">
      {showImage ? (
        <img
          src={image}
          alt={`Paisaje de ${analog.name}`}
          loading={loading}
          onError={() => setFailedImage(image)}
        />
      ) : (
        <div className="photo-placeholder">
          <span>{analog.image ? 'Fotografía no disponible' : 'Fotografía pendiente'}</span>
        </div>
      )}
    </div>
  )
}
