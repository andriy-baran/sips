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
    setTotal();
  });

  $('.pos-ui .discard').on('click', function(e) {
    $('.pos-ui #order-items .line-item').remove();
    $('.pos-ui .total').text('Загальна сума: 0 UAH');
  })

  $('.pos-ui .payment').on('click', function(e) {
    if ($('.pos-ui #order-items .line-item').length > 0) {
      $(e.target).removeClass('payment').addClass('pay-cash').text('Готівка');
      $('.pos-ui .discard').off('click').removeClass('discard').removeClass('btn-outline-danger').addClass('btn-outline-info').addClass('pay-card').text('Картка');
      $('.pos-ui .order-controls .pay-card').on('click', function(e) {
        $('form#order #payment_type').val('card');
        $('form#order').submit();
      });
      $('.pos-ui .order-controls .pay-cash').on('click', function(e) {
        $('form#order').submit();
      })
    } else {
      return false;
    }
  })

  bindReactions();
  setTotal();
})

$(window).on("resize", function() {
  adoptHeight();
})

function bindReactions() {
  $('.pos-ui #order-items .list-group-item #quantity').on('change', function(e) {
    var quantity = parseInt(e.target.value);
    if (quantity == 0 || Number.isNaN(quantity)) {
      $(e.target).closest('.list-group-item').remove();
    } else {
      var price = parseFloat($(e.target).data().price);
      $(e.target).closest('.list-group-item').find('.subtotal').text((price*quantity)+' UAH');
    }
    setTotal();
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
  return '<div class="list-group-item py-2 line-item border-left-0 border-right-0" id="variant-'+id+'">'+
      '<div class="row d-flex align-items-center">'+
        '<input name="order[items][][variant_id]" type="hidden" id="variant_id" value="'+id+'">'+
        '<div class="col-7">'+
          '<big>'+product+'</big>'+
        '</div>'+
        '<div class="col-3 row">'+
          '<input name="order[items][][quantity]" class="form-control" min="0" type="number" id="quantity" value="'+quantity+'" data-price="'+price+'">'+
        '</div>'+
        '<div class="col-2 text-right pr-0 ml-3">'+
          '<big class="subtotal">'+subtotal+' UAH</big>'+
        '</div>'+
      '</div>'+
    '</div>';
}

function adoptHeight() {
  var screenHeight =  window.innerHeight;
  var screenWidth =  window.innerWidth;
  if (screenHeight > screenWidth) {
    $('.pos-ui').height(screenHeight - 135);
  } else {
    $('.pos-ui').height(screenHeight - 135);
  }
  var ordersDivHeight = $('.pos-ui .order').height();
  var totalDivHeight = $('.pos-ui .total').outerHeight();
  var headerDivHeight = $('.pos-ui .order-header').outerHeight();
  $('.pos-ui #order-items').height(ordersDivHeight - (totalDivHeight + headerDivHeight));
  $('.pos-ui #order-items').css({'margin-bottom': totalDivHeight});
}

