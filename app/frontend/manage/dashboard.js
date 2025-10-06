// Dashboard JavaScript functionality
import './dashboard.css'

// Initialize dashboard when DOM is ready
document.addEventListener('turbolinks:load', function() {
  if (document.getElementById('dashboard-grid')) {
    // Wait for libraries to be available
    if (typeof GridStack !== 'undefined' && typeof $ !== 'undefined') {
      initializeDashboard();
    } else {
      console.error('GridStack or jQuery not available');
      // Retry after a short delay
      setTimeout(function() {
        if (typeof GridStack !== 'undefined' && typeof $ !== 'undefined') {
          initializeDashboard();
        }
      }, 100);
    }
  }
});

function initializeDashboard() {
  // Initialize GridStack
  var grid = GridStack.init({
    column: 12,
    cellHeight: 70,
    removable: '#trash-can',
    acceptWidgets: '.draggable-widget'
  });

  // Make sidebar widgets draggable
  $('.draggable-widget').draggable({
    revert: 'invalid',
    helper: 'clone',
    cursor: 'move',
    appendTo: 'body',
    zIndex: 1000
  });

  // Handle widget addition
  grid.on('added', function(event, items) {
    console.log('Widget added:', items);
  });

  // Handle widget removal
  grid.on('removed', function(event, items) {
    console.log('Widget removed:', items);
  });

  // Handle widget change
  grid.on('change', function(event, items) {
    console.log('Widget changed:', items);
    // Here you can save the layout to the server
  });
}