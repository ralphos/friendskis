function salesModal(e) {
  
  $('#sales-modal').modal({show:true, backdrop: true});        
  $('#sales-modal').find('.modal-header').html("<h3>Get friendly on Friendskis...<h3>");

  $('#sales-click').bind('click', function() {
    $('#sales-modal').modal('hide');
  });

  $('#free-trial').bind('click', function() {
    $('#sales-modal').modal('hide');
  });

}

