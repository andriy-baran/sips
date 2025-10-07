import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import inject from '@rollup/plugin-inject';

export default defineConfig({
  plugins: [
    inject({
      $: 'jquery',
      jQuery: 'jquery',
      include: ['**/*.js', '**/*.ts', '**/*.jsx', '**/*.tsx']
    }),
    RubyPlugin(),
  ],
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          jquery: ['jquery', 'jquery-ui-dist/jquery-ui'],
          gridstack: ['gridstack'],
          bootstrap: ['bootstrap'],
          chartjs: ['chart.js'],
          rails: ['@rails/ujs', 'turbolinks', '@rails/actioncable']
        }
      }
    }
  },
  optimizeDeps: {
    include: ['jquery', 'jquery-ui-dist'], // Helps Vite optimize jQuery dependencies
  },
})
