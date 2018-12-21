$( document ).on('turbolinks:load', function() {
  $('.product-ckeckout').on('ajax:success', function(event){
    $(event.target).closest('.list-group-item').remove();
    [data, status, xhr] = event.detail;
    $('#reported').append(xhr.responseText);
  })

  bindEditCheckout();
});

function bindEditCheckoutSuccess() {
  $('.product-ckeckout-edit').on('ajax:success', function(event){
    [data, status, xhr] = event.detail;
    $(event.target).closest('.list-group-item').replaceWith(xhr.responseText);
    bindEditCheckout();
  })
}

function bindEditCheckout() {
  $('.edit-checkout').on('ajax:success', function(event){
    [data, status, xhr] = event.detail;
    $(event.target).closest('.list-group-item').replaceWith(xhr.responseText);
    bindEditCheckoutSuccess();
  })
}
