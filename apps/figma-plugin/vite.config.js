import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
export default defineConfig({
  plugins: [react()],
  build: {
    rollupOptions: {
      input: {
        ui: './index.html',
        plugin: './src/plugin/main.ts',
      },
      output: {
        entryFileNames: '[name].js',
      },
    },
  },
})
