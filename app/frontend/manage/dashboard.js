// Dashboard JavaScript functionality
import './dashboard.css'

// Initialize dashboard when DOM is ready
document.addEventListener('turbolinks:load', function() {
  if (document.getElementById('dashboard-grid')) {
    // Wait a bit for jQuery UI to load
    setTimeout(() => {
      initializeDashboard();
    }, 200);
  }
});

function initializeDashboard() {
  try {
    // Check if jQuery UI is available
    if (typeof $.fn.draggable === 'undefined') {
      console.warn('jQuery UI draggable not available, initializing without drag functionality');
      // Continue without draggable functionality
    }

    // Initialize GridStack
    var grid = GridStack.init({
      column: 12,
      cellHeight: 70,
      removable: '#trash-can',
      acceptWidgets: '.draggable-widget'
    });

    // Make sidebar widgets draggable only if jQuery UI is available
    if (typeof $.fn.draggable !== 'undefined') {
      $('.draggable-widget').draggable({
        revert: 'invalid',
        helper: 'clone',
        cursor: 'move',
        appendTo: 'body',
        zIndex: 1000,
        connectToSortable: '.grid-stack',
        start: function(event, ui) {
          // Store the widget type for when it's dropped
          ui.helper.data('widget-type', $(this).data('widget-type'));
        }
      });

      // Make the grid a drop target
      $('.grid-stack').droppable({
        accept: '.draggable-widget',
        drop: function(event, ui) {
          var widgetType = ui.helper.data('widget-type');
          var position = grid.getCellFromPixel(event, false);

          // Create new widget based on type
          var newWidget = createWidget(widgetType, position.x, position.y);

          // Append widget to grid container
          var gridContainer = document.querySelector('.grid-stack');
          gridContainer.appendChild(newWidget.el);

          // Initialize widget with makeWidget() for GridStack v11+
          grid.makeWidget(newWidget.el);
        }
      });

      // Make trash can a drop target for removing widgets
      $('#trash-can').droppable({
        accept: '.grid-stack-item',
        drop: function(event, ui) {
          // Find the grid item and remove it
          var gridItem = ui.draggable.closest('.grid-stack-item');
          if (gridItem.length) {
            grid.removeWidget(gridItem[0]);
          }
        }
      });
    }

    // Handle widget addition
    grid.on('added', function(event, items) {
      // Widget was added to the grid
    });

    // Handle widget removal
    grid.on('removed', function(event, items) {
      // Widget was removed from the grid
    });

    // Handle widget change
    grid.on('change', function(event, items) {
      // Here you can save the layout to the server
    });
  } catch (error) {
    console.error('Error initializing dashboard:', error);
  }
}

// Function to create widgets based on type
function createWidget(widgetType, x, y) {
  var contentHtml = '';

  switch(widgetType) {
    case 'sales-card':
      contentHtml = `
        <div class="card text-white bg-success h-100">
          <div class="card-body">
            <div class="row d-flex align-items-center">
              <div class="col-4">
                <i class="fa fa-money fa-4x"></i>
              </div>
              <div class="col-8">
                <h3 class="mb-0">0 UAH</h3>
                Зароблено сьогодні
              </div>
            </div>
          </div>
        </div>
      `;
      break;

    case 'inventory-card':
      contentHtml = `
        <div class="card text-white bg-warning h-100">
          <div class="card-body">
            <div class="row d-flex align-items-center">
              <div class="col-4">
                <i class="fa fa-shopping-cart fa-4x"></i>
              </div>
              <div class="col-8">
                <h3 class="mb-0">0</h3>
                Порцій продано
              </div>
            </div>
          </div>
        </div>
      `;
      break;

    case 'chart-card':
      contentHtml = `
        <div class="card h-100">
          <div class="card-header">
            <h5 class="mb-0">Графік прибутку</h5>
          </div>
          <div class="card-body">
            <canvas style="height: 100%; width: 100%;"></canvas>
          </div>
        </div>
      `;
      break;

    default:
      contentHtml = `
        <div class="card h-100">
          <div class="card-body">
            <h5>Новий віджет</h5>
            <p>Тип: ${widgetType}</p>
          </div>
        </div>
      `;
  }

  // Create the widget element following GridStack v11+ documentation
  var widget = document.createElement('div');
  widget.classList.add('grid-stack-item');

  // Set GridStack-specific attributes
  widget.setAttribute('gs-x', x);
  widget.setAttribute('gs-y', y);
  widget.setAttribute('gs-w', 4);
  widget.setAttribute('gs-h', 3);

  // Create content element
  var widgetContent = document.createElement('div');
  widgetContent.classList.add('grid-stack-item-content');
  widgetContent.innerHTML = contentHtml;

  // Append content to widget
  widget.appendChild(widgetContent);

  return {
    x: x,
    y: y,
    w: 4,
    h: 3,
    el: widget
  };
}