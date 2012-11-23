function sendRequestViaMultiFriendSelector() {
  FB.ui({method: 'apprequests',
      filters: ["app_non_users"],
      message: 'Come check out this awesome new app I joined called Friendskis! Click now!'
    }, requestCallback);
}

function requestCallback(response) {

  $.ajax({
    url: "/invites",
    type: 'POST',
    data: { ids: response.to, fb_request_id: response.request },
    success: function(e) {
      if(e.success == true)  {
      } else {
        alert("Sorry! Something went wrong.") 
      }
    }
 })

}
