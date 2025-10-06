// Import styles
import '~/index.css'

// Import jQuery and Bootstrap
import $ from 'jquery'
import 'bootstrap'
import Rails from '@rails/ujs'
import * as Turbolinks from 'turbolinks'

// Start Rails UJS and Turbolinks
Rails.start()
Turbolinks.start()

// Make jQuery available globally
window.$ = window.jQuery = $

// Auto-close alerts after 3 seconds
document.addEventListener('turbolinks:load', function() {
  setTimeout(function() {
    $(".alert").alert('close');
  }, 3000);
});

// Import JavaScript files
import '../analytics'
import '../cable'
import '../manage/checkins'
import '../manage/users'
import '../trade/checkouts'
import '../trade/point_of_sales'
