import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  base: 'https://bia-bia-web.dutk9f.easypanel.host/build/',
})