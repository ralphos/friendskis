function sendRequestViaMultiFriendSelector() {
  FB.ui({method: 'apprequests',
      message: 'Invite 25 or more friends and get 2 weeks free access to Friendskis!'
    }, requestCallback);
}

function requestCallback(response) { 
  // Handle callback here
}
