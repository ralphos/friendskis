function sendRequestViaMultiFriendSelector() {
  FB.ui({method: 'apprequests',
      filters: ["app_non_users"],
      message: "Join me on Friendskis and make new friends on Facebook!"
    }, requestCallback);
}

function requestCallback(response) {

  $.ajax({
    url: "/invites",
    type: 'POST',
    data: { ids: response.to, fb_request_id: response.request },
    success: function(e) {
      if(e.success == true)  {
        $('#invite_count').html(e.invite_count)
      } else {
        alert("Sorry! Something went wrong.") 
      }
    }
 })

}
