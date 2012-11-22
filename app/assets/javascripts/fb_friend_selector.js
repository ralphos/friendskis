function sendRequestViaMultiFriendSelector() {
  FB.ui({method: 'apprequests',
      message: 'My Great Request'
    }, requestCallback);
}

function requestCallback(response) { 
  // Handle callback here
}
