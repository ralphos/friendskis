
// The dialog only opens if you've implemented the
// Credits Callback payments_get_items.
function buySubscription(subscriptionUrl) {
  var obj = {
    method: 'pay',
    order_info: {'item_id': '1a', 'price': '9.99 USD'},     
    dev_purchase_params: {'oscif': true},
    action: 'create_subscription',
    product: subscriptionUrl
  };

  FB.ui(obj, js_callback);
}

// This JavaScript callback handles FB.ui's return data and differs
// from the Credits Callbacks.
var js_callback = function(data) {

  $.ajax({
    type: 'POST',
    url: '/subscriptions/update', 
    data: {
      subscription_id: data.subscription_id,
      subscription_status:  data.status
    },
    success: function(e) {
      if(e.success == true) {

      }
    }
  })

  // TODO: Post to subscriptions controller the data that we got from facebook.
};
