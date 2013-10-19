# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('a.toggle-mode').bind 'click', ->
    if !$(this).hasClass "active"
      $('a.toggle-mode').removeClass "active"
      $(this).addClass "active"
      $("form").toggle()

    return false