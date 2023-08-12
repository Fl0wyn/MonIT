import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'

import '@tabler/core/dist/css/tabler.min.css'
import '@tabler/core/dist/js/tabler.min.js'

const app = createApp(App)

app.use(createPinia())

app.mount('#app')
