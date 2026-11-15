import { defineConfig, type Plugin } from 'vite'
import react from '@vitejs/plugin-react'

// WhatsApp y las redes solo muestran la vista previa si og:image es una URL completa.
// En Vercel se usa el dominio de producción que Vercel informa al compilar; en local queda relativa.
function absoluteShareImage(): Plugin {
  const host = process.env.VERCEL_PROJECT_PRODUCTION_URL
  return {
    name: 'absolute-share-image',
    transformIndexHtml(html) {
      return host ? html.replace('content="/og-image.png"', `content="https://${host}/og-image.png"`) : html
    },
  }
}

export default defineConfig({
  plugins: [react(), absoluteShareImage()],
  // Los recursos se resuelven desde la raíz también al recargar /luna o /marte.
  base: '/',
})
