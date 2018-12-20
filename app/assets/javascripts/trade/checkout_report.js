$( document ).on('turbolinks:load', function() {
  $('.product-ckeckout').on('ajax:success', function(e, data){
    $(e.target).closest('.list-group-item').remove();
    $('#reported').append(data);
  })
});
