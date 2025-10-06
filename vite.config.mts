import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import inject from '@rollup/plugin-inject';

export default defineConfig({
  plugins: [
    inject({
      $: 'jquery',
      jQuery: 'jquery'
    }),
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
  },
  optimizeDeps: {
    include: ['jquery'], // Helps Vite optimize jQuery dependency
  },
})
