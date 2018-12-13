$( document ).on('turbolinks:load', function() {
  adoptHeight();

  $('.pos-ui .product').on('click', function(e) {
    var info, quantity = 1;
    if ($(e.target).hasClass('product')) {
      info = $(e.target).data();
    } else {
      info = $(e.target).closest('.product').data();
    }
    var price = parseFloat(info.price);
    var itemForm = $('.pos-ui #order-items').children('#variant-'+info.id);
    if (itemForm.length > 0) {
      quantity = parseInt(itemForm.find('#quantity')[0].value);
      quantity = quantity + 1;
    }
    var subtotal = price * quantity;
    var template = renderTemplate(info.id, info.product, subtotal, quantity, price)
    if (itemForm.length > 0) {
      itemForm.replaceWith(template);
    } else {
      $('.pos-ui #order-items').append(template);
    }
    bindReactions();
    setTotal()
  })

  bindReactions();
  setTotal()
})

$(window).on("resize", function() {
  adoptHeight();
})

function bindReactions() {
  $('.pos-ui #order-items .list-group-item #quantity').on('change', function(e) {
    var quantity = parseInt(e.target.value);
    if (quantity == 0 || quantity == NaN) {
      $(e.target).closest('.list-group-item').remove();
    } else {
      var price = parseFloat($(e.target).data().price);
      $(e.target).closest('.list-group-item').find('.subtotal').text((price*quantity)+' UAH');
    }
  })
}

function setTotal() {
  var total = 0;
  $('.pos-ui #order-items .subtotal').each(function(){
    total += parseInt($(this).text());
  })
  $('.pos-ui .total').text('Загальна сума: '+total+' UAH')
}

function renderTemplate(id, product, subtotal, quantity, price) {
  return '<div class="list-group-item py-2" id="variant-'+id+'">'+
      '<div class="row d-flex align-items-center">'+
        '<input name="items[]item[variant_id]" type="hidden" id="variant_id" value="'+id+'">'+
        '<div class="col-7">'+
          '<big>'+product+'</big>'+
        '</div>'+
        '<div class="col-3 row">'+
          '<input name="items[]item[quantity]" class="form-control" min="0" type="number" id="quantity" value="'+quantity+'" data-price="'+price+'">'+
        '</div>'+
        '<div class="col-2 text-right pr-0 ml-3">'+
          '<big class="subtotal">'+subtotal+' UAH</big>'+
        '</div>'+
      '</div>'+
    '</div>';
}

function adoptHeight() {
  var documentHeight =  $( document ).height();
  $('.pos-ui').height(documentHeight - 135);
}
