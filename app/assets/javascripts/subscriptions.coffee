$(document).ready ->

  $('input[type=radio]', '#new_subscription').on 'change', ->
    $('.radio').toggleClass('active')

  $('input[type=radio]', '#edit_subscription').on 'change', ->
    $('.radio').toggleClass('active')

  Stripe.setPublishableKey($("meta[name='stripe-key']").attr('content'))
  $('#stripe-submit').click ->
    $('#new_subscription').submit ->
      false

    if !validate_card()
      return

    $('#stripe-submit').prop('disabled', true)

    Stripe.card.createToken({
      number: $('#card_number').val(),
      cvc: $('#cvc').val(),
      exp_month: $('#card_month').val(),
      exp_year: $('#card_year').val()
    }, stripeResponseHandler)

stripeResponseHandler = (status, response)->
  $form = $('#new_subscription')
  add_form_fields(status, response, $form)

@updateStripeCard = ->
  $('#update-subscription').submit ->
    false

  if !validate_card()
    return

  $('#update-stripe-submit').prop('disabled', true)
  Stripe.card.createToken({
    number: $('#card_number').val(),
    cvc: $('#cvc').val(),
    exp_month: $('#card_month').val(),
    exp_year: $('#card_year').val()
  }, updateCardHandler)

updateCardHandler = (status, response)->
  $form = $('#update-subscription')
  add_form_fields(status, response, $form)

add_form_fields = (status, response, form)->
  if response.error
    console.log(response.error.message)
  else
    token = response.id

    form.append $('<input type="hidden" name="payment_token" />').val(token)

    form.append $('<input type="hidden" name="card_last4" />').val(response.card.last4)
    form.append $('<input type="hidden" name="card_exp_month" />').val(response.card.exp_month)
    form.append $('<input type="hidden" name="card_exp_year" />').val(response.card.exp_year)
    form.append $('<input type="hidden" name="card_brand" />').val(response.card.brand)

    form.get(0).submit()

validate_card = ->
  validator.validate_presence('#card_number') &&
  validator.validate_min_length('#card_number', 13) &&
  validator.validate_max_length('#card_number', 19) &&
  validator.validate_presence('#cvc') &&
  validator.validate_min_length('#cvc', 3) &&
  validator.validate_max_length('#cvc', 4)




