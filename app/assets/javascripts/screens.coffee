# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$(document).on 'turbolinks:load', ->

$(document).on 'click', '.reveal-link', (e)->
  $('#modal-image').attr('src', $(this).find('img').first().attr('src'))
  console.log($(this).attr('data-category'))
  $('.modal-download-count').text($(this).find('.download-count').first().text())
  $('.modal-favorites-count').text($(this).find('.favorites-count').first().text())
  $('.modal-category').text('Category: ' + $(this).attr('data-category'))
  $('.modal-tag').text('Tag: ' + $(this).attr('data-tag'))
  e.preventDefault()

  $('#reveal-modal').foundation('open')

$(document).on 'click', '.close-reveal-modal', (e)->
  e.preventDefault()
  $('#reveal-modal').foundation('close')
