// Import styles
import '~/index.css'

// Import jQuery and Bootstrap
import $ from 'jquery'
import 'bootstrap'
import Rails from '@rails/ujs'
import * as Turbolinks from 'turbolinks'

// Import Chart.js
import Chart from 'chart.js/auto'

// Import Gridstack
import 'gridstack/dist/gridstack.min.css'
import { GridStack } from 'gridstack'

// Make jQuery available globally before other libraries
window.$ = window.jQuery = $

// Make Chart.js available globally
window.Chart = Chart

// Make GridStack available globally
window.GridStack = GridStack

// Start Rails UJS and Turbolinks
Rails.start()
Turbolinks.start()

// Auto-close alerts after 3 seconds
document.addEventListener('turbolinks:load', function() {
  setTimeout(function() {
    $(".alert").alert('close');
  }, 3000);
});

// Import JavaScript files
import '../analytics'
import '../cable'
import '../manage/dashboard'
import '../trade/checkouts'
import '../trade/point_of_sales'
