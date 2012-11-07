$.ajaxSetup beforeSend: (xhr) ->
  # console.log "ajaxSetup:beforeSend"
  xhr.withCredentials = true
  xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
  xhr.setRequestHeader "X-Session", Application.meta.session if Application.meta.session?
  xhr.setRequestHeader "X-FB-ID", Application.fb.userID
  xhr.setRequestHeader "X-FB-AccessToken", Application.fb.accessToken 

  true

# Rails remote forms
$(document).on 'ajax:beforeSend', (e,xhr) ->
  # console.log "ajax:beforeSend"
  xhr.withCredentials = true
  xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
  xhr.setRequestHeader "X-Session", Application.meta.session if Application.meta.session?
  xhr.setRequestHeader "X-FB-ID", Application.fb.userID
  xhr.setRequestHeader "X-FB-AccessToken", Application.fb.accessToken 

  true
