# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

on_signup = (event) ->
  # TODO: verify password confimation
  srp = new SRP
  salt = srp.salt()
  $('#srp_salt').val(salt)
  $('#srp_password_verifier').val(srp.calcV(salt))
  # clear the password so we do not submit it
  $('#srp_password').val('')
  $('#srp_confirmation').val('')

$(document).ready ->
  $('#new_user').submit on_signup

