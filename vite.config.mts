import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'

export default defineConfig({
  plugins: [
    RubyPlugin(),
  ],
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['jquery', 'bootstrap'],
          rails: ['@rails/ujs', 'turbolinks', '@rails/actioncable']
        }
      }
    }
  }
})
