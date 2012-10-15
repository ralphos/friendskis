function showModal(e) {
  
  $('#my-modal').modal({show:true, backdrop: true});        
  $('#my-modal').find('.modal-header').html("<h3>Send a message to " + e.data('username') + "</h3>");
  
  console.log(e.data('recipients'));
  console.log(e.data('recipients-username'));
  
  
  $('#message_recipients_id').val(e.data('recipients'));
  $('#message_recipients_username').val(e.data('recipients-username'));
  
  console.log($('#message_recipients_id').val());

}

