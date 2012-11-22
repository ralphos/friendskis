function sendRequestViaMultiFriendSelector() {
  FB.ui({method: 'apprequests',
      message: 'Come check out this awesome new app I joined called Friendskis! Click now!'
    }, requestCallback);
}

function requestCallback(response) { 
  // Handle callback here

}
