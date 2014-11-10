# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$.ajax
  url: "/posts/fetch_result"
  method: 'get'
  success: (data) ->
    unless data["done"]
      $('#post-progressbar .progress-pre').text("10% Complete")
      $('#post-progressbar .progress-bar').width "10%"
      uploadR.delayGetResult()
    else
      $('#post-progressbar .time').text("Last At: #{ data['last_time'] }")

uploadR =
  getUploadResult: ->
    $.ajax
      url: "/posts/fetch_result"
      method: 'get'
      success: (data) ->
        if data["done"]
          $('#post-progressbar .progress-pre').text("100% Complete, Total: #{ data['fetch_count'] }")
          $('#post-progressbar .time').text("Last At: #{ data['last_time'] }")
          $('#post-progressbar .progress-bar').width '100%'
        else
          if $('#post-progressbar .progress-bar').width() < 250
            procentage = $('#post-progressbar .progress-bar').width() + 13
          $('#post-progressbar .progress-pre').text("#{ parseInt(procentage*100/268) }% Complete")
          $('#post-progressbar .progress-bar').width procentage
          uploadR.delayGetResult()
      error: (jqXHR) ->
        console.log(jqXHR.responseJSON)
  delayGetResult: ->
    uploadR.timeId = setTimeout(uploadR.getUploadResult, 2000)
  timeId: null

$(document).on 'ajax:success', '.fetch-all-posts-btn', (e) ->
  $('#post-progressbar .progress-pre').text("10% Complete")
  $('#post-progressbar .progress-bar').width "10%"
  uploadR.delayGetResult()

$(document).on 'ajax:error', '.fetch-all-posts-btn', (e) ->
  alert('Working')

$(document).on 'click', '.post-comment', (e) ->
  this.contentEditable = true

$(document).on 'focus', '.post-comment', (e) ->
  $(this).addClass('editing')

$(document).on 'blur', '.post-comment', (e) ->
  $(this).removeClass('editing')
  $.ajax
    url: "posts/#{ $(this).data().id }"
    type: 'PATCH'
    data:
      comment: $(this).text()
    success: -> console.log 'success'
    error: -> console.log 'error'

$(document).on 'keyup', '.post-comment', (e) ->
  if e.keyCode == 13
    $(this).blur()

$(document).on 'mouseover', '.post-title', (e) ->
  $(this).tooltip('show')
