import '~/index.css'
import $ from 'jquery'
import 'bootstrap'
import 'jquery-ui-dist/jquery-ui';
import Rails from '@rails/ujs'
import * as Turbolinks from 'turbolinks'
import Chart from 'chart.js/auto'
import 'gridstack/dist/gridstack.min.css'
import { GridStack } from 'gridstack'

window.$ = window.jQuery = $
window.Chart = Chart
window.GridStack = GridStack


Rails.start()
Turbolinks.start()

document.addEventListener('turbolinks:load', function() {
  setTimeout(function() {
    $(".alert").alert('close');
  }, 3000);
});

import '../cable'
import '../manage/dashboard'
import '../trade/checkouts'
import '../trade/point_of_sales'
