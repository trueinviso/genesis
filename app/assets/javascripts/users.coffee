$(document).ready ->
  $('#new-user-submit').click ->
    $('#new_user').submit ->
      false

    $form = $('#new_user')

    if validate_new_user()
      $form.get(0).submit()
    else
      return

  $('#sign-in').click ->
    $('#sign-in-form').submit ->
      false

    $form = $('#sign-in-form')

    if validate_sign_in()
      $form.get(0).submit()

validate_new_user = ->
  validator.validate_presence('#user_first_name') &&
  validator.validate_max_length('#user_first_name', 256) &&
  validator.validate_presence('#user_last_name') &&
  validator.validate_max_length('#user_last_name', 256) &&
  validator.validate_presence('#user_email') &&
  validator.validate_email_format('#user_email') &&
  validator.validate_presence('#user_username') &&
  validator.validate_presence('#user_password') &&
  validator.validate_max_length('#user_password', 25) &&
  validator.validate_min_length('#user_password', 8)

validate_sign_in = ->
  validator.validate_presence('#sign-in-email') &&
  validator.validate_presence('#sign-in-password')
