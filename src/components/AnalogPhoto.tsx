import { useState } from 'react'
import { useI18n } from '../i18n/I18nProvider'
import type { Analog } from '../types/domain'

interface AnalogPhotoProps {
  /** El nombre llega ya traducido: se usa en el texto alternativo de la foto. */
  analog: Pick<Analog, 'name' | 'image'>
  loading?: 'eager' | 'lazy'
}

export default function AnalogPhoto({ analog, loading = 'lazy' }: AnalogPhotoProps) {
  const { t } = useI18n()
  const [failedImage, setFailedImage] = useState<string | null>(null)
  const rawImage = analog.image ?? ''
  const image = rawImage.startsWith('img/') ? `/${rawImage}` : rawImage
  const showImage = Boolean(image && failedImage !== image)

  return (
    <div className="analog-photo">
      {showImage ? (
        <img
          src={image}
          alt={t.photo.alt(analog.name)}
          loading={loading}
          onError={() => setFailedImage(image)}
        />
      ) : (
        <div className="photo-placeholder">
          <span>{analog.image ? t.photo.unavailable : t.photo.pending}</span>
        </div>
      )}
    </div>
  )
}
