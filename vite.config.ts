import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  // Los recursos se resuelven desde la raíz también al recargar /luna o /marte.
  base: '/',
})
