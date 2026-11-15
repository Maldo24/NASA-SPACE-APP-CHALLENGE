import React from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import 'leaflet/dist/leaflet.css'
import './App.css'
import App from './App.tsx'
import { I18nProvider } from './i18n/I18nProvider.tsx'

const root = document.getElementById('root')
if (!root) throw new Error('No se encontró el elemento #root en index.html')

ReactDOM.createRoot(root).render(
  <React.StrictMode>
    <BrowserRouter future={{ v7_startTransition: true, v7_relativeSplatPath: true }}>
      <I18nProvider>
        <App />
      </I18nProvider>
    </BrowserRouter>
  </React.StrictMode>
)
