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
