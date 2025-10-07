$( document ).on('turbolinks:load', function() {
  $('.product-stock-record').on('ajax:success', function(event){
    $(event.target).closest('.list-group-item').remove();
    [data, status, xhr] = event.detail;
    $('#reported').append(xhr.responseText);
    bindEditCheckout();
  })

  bindEditCheckout();
});

function bindEditCheckoutSuccess() {
  $('.product-stock-record-edit').on('ajax:success', function(event){
    [data, status, xhr] = event.detail;
    $(event.target).closest('.list-group-item').replaceWith(xhr.responseText);
    bindEditCheckout();
  })
}

function bindEditCheckout() {
  $('.edit-record').on('ajax:success', function(event){
    [data, status, xhr] = event.detail;
    $(event.target).closest('.list-group-item').replaceWith(xhr.responseText);
    bindEditCheckoutSuccess();
  })
}

