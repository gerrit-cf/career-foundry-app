App.product = App.cable.subscriptions.create('ProductChannel', {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    $('.alert.alert-info').show();
  },

  listenToComments: function() {
    const productId = $('[data-product-id]').data('product-id')
    return this.perform('listen', { 'product-id': productId })
  }
});

$(document).on('turbolinks:load', () => {
  App.product.listenToComments()
})
