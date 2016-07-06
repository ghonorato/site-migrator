# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'ajax:error', '#new-migration-modal', (e, xhr) ->
    $(this).find('form').replaceWith(xhr.responseText)

  $(document).on 'ajax:success', '#new-migration-modal', (e, html, status, xhr) ->
    redirect_to = xhr.getResponseHeader('Location')
    window.location = redirect_to if redirect_to