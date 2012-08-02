on_authenticated = (event) ->
  window.location = '/'

path_translation = (path) ->
  switch path
    when "handshake/" then "sessions"
    when "authenticate/" then "sessions/" + $('#srp_username').val()

on_login = (event) ->
  srp = new SRP
  srp.paths = path_translation
  srp.success = on_authenticated
  srp.identify()
  false

$(document).ready ->
  $('#new_session').submit(on_login)


