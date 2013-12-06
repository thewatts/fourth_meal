$('.add-to-cart').click(function(e) {
  e.preventDefault();
  var itemId = this.previousElementSibling.value;
  debugger;
  $.ajax({
    url: '/orders/12',
    type: 'PUT',
    data: { item: itemId },
    success: function(data) {
      $( "#cart-total" ).html( "1 Item Added to Cart");
    }
  });

  $( "#cart-total" ).html( "1 Item Added to Cart");
});