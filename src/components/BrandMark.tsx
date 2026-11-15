import { useId } from 'react'

// Símbolo de Pacha-X (el mismo dibujo que public/brand/pacha-x-logo.svg y el favicon).
// Toma el color del texto (currentColor), así sirve sobre fondo claro u oscuro.
export default function BrandMark({ className }: { className?: string }) {
  const maskId = useId()
  return (
    <svg className={className} viewBox="56 8 192 192" aria-hidden="true" focusable="false">
      <mask id={maskId}>
        <rect x="0" y="0" width="256" height="256" fill="#fff" />
        <circle cx="116" cy="140" r="16.25" fill="#000" />
      </mask>
      <path fill="currentColor" mask={`url(#${maskId})`}
        d="M88 112h56v56h-56z M88 84.75l27.25 27.25l-27.25 27.25l-27.25 -27.25z M88 112.75l27.25 27.25l-27.25 27.25l-27.25 -27.25z M88 140.75l27.25 27.25l-27.25 27.25l-27.25 -27.25z M116 84.75l27.25 27.25l-27.25 27.25l-27.25 -27.25z M116 112.75l27.25 27.25l-27.25 27.25l-27.25 -27.25z M116 140.75l27.25 27.25l-27.25 27.25l-27.25 -27.25z M144 84.75l27.25 27.25l-27.25 27.25l-27.25 -27.25z M144 112.75l27.25 27.25l-27.25 27.25l-27.25 -27.25z M144 140.75l27.25 27.25l-27.25 27.25l-27.25 -27.25z" />
      <path fill="currentColor" d="M212 12L219 36.75L243.75 43.75L219 50.75L212 75.5L205 50.75L180.25 43.75L205 36.75Z" />
    </svg>
  )
}
