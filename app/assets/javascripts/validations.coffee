@validator =
  validate_presence: (id)->
    is_valid = $(id).val().length > 0
    @.set_red_border(is_valid, id)
    @.error_message_check(id, is_valid, 'This field is required')
    return is_valid

  validate_min_length: (id, length)->
    is_valid = $(id).val().length >= length
    @.set_red_border(is_valid, id)
    @.error_message_check(id, is_valid, 'The minimum length is ' + length + ' characters')
    return is_valid

  validate_max_length: (id, length)->
    is_valid = $(id).val().length <= length
    @.set_red_border(is_valid, id)
    @.error_message_check(id, is_valid, 'The maximum length is ' + length + ' characters')
    return is_valid

  validate_subdomain_format: (id)->
    VALID_SUBDOMAIN_REGEX = /^[a-z0-9-]+$/
    is_valid = VALID_SUBDOMAIN_REGEX.test($(id).val())
    @.set_red_border(is_valid, id)
    @.error_message_check(id, is_valid, 'Not a valid subdomain')
    return is_valid

  validate_email_format: (id)->
    VALID_EMAIL_REGEX = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/
    is_valid = VALID_EMAIL_REGEX.test($(id).val())
    @.set_red_border(is_valid, id)
    @.error_message_check(id, is_valid, 'Not a valid email')
    return is_valid

  validate_passwords_match: (p_id, pc_id)->
    is_valid = $(p_id).val() == $(pc_id).val()
    @.set_red_border(is_valid, p_id)
    @.set_red_border(is_valid, pc_id)
    @.error_message_check(p_id, is_valid, "Passwords don't match")
    return is_valid

  validate_acceptance_of: (id)->
    is_valid = $(id).is(':checked')
    @.error_message_check(id, is_valid, 'You must accept terms and conditions.')
    return is_valid

  set_red_border: (is_valid, id)->
    if is_valid
      @.remove_red_border(id)
    else
      @.add_red_border(id)

  add_red_border: (id)->
    $(id).css('border-color', ->
      return 'red')

  error_message_check: (id, is_valid, message)->
    if is_valid
      @.hide_error_message(id)
    else
      @.show_error_message(id, message)

  # name error message id divs with id of field + `-error`
  show_error_message: (id, message)->
    $(id + '-error').text(message)
    $(id + '-error').show()

  hide_error_message: (id)->
    $(id + '-error').hide()

  remove_red_border: (id)->
    $(id).css('border-color', ->
      $(this).removeAttr('style'))
