$(document).ready ->

  $('input[type=radio]', '#new_subscription').on 'change', ->
    $('.radio').toggleClass('active')

  $('input[type=radio]', '#edit_subscription').on 'change', ->
    $('.radio').toggleClass('active')

  Stripe.setPublishableKey($("meta[name='stripe-key']").attr('content'))
  $('#stripe-submit').click ->
    $('#new_subscription').submit ->
      false

    $('#stripe-submit').prop('disabled', true)

    Stripe.card.createToken({
      number: $('#card_number').val(),
      cvc: $('#cvc').val(),
      exp_month: $('#card_month').val(),
      exp_year: $('#card_year').val()
    }, stripeResponseHandler)

stripeResponseHandler = (status, response)->
  $form = $('#new_subscription')
  if response.error
    console.log(response.error.message)
  else
    token = response.id

    $form.append $('<input type="hidden" name="payment_token" />').val(token)

    $form.append $('<input type="hidden" name="card_last4" />').val(response.card.last4)
    $form.append $('<input type="hidden" name="card_exp_month" />').val(response.card.exp_month)
    $form.append $('<input type="hidden" name="card_exp_year" />').val(response.card.exp_year)
    $form.append $('<input type="hidden" name="card_brand" />').val(response.card.brand)

    $form.get(0).submit()


    #$.when($('#payment_token').val(token)).then ->
    #  $('#new_subscription')[0].submit()


