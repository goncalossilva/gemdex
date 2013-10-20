# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.toggleMode = (mode) ->
  $('.input').hide()
  $('a.toggle-mode').removeClass "on"
  mode.addClass "on"
  $("form").toggle()
  $('.input').fadeIn(500)

window.setInitialMode = ->
  mode = window.location.hash.substring(1);
  if mode == "battle"
    toggleMode($("a#battle"))

window.renderInput = ->
  $('.input').fadeIn(500)

$ ->
  setInitialMode()
  renderInput()

  $('a.toggle-mode').bind 'click', ->
    if !$(this).hasClass "on"
      toggleMode($(this))
    return false