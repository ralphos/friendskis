function salesModal(e) {
  
  $('#sales-modal').modal({show:true, backdrop: true});        
  $('#sales-modal').find('.modal-header').html("<h3>Become a subscriber</h3>");

  $('#sales-click').bind('click', function() {
    $('#sales-modal').modal('hide');
  });

}

