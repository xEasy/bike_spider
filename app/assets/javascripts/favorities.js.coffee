$ ->
  $(document).on 'ajax:success', ".favory", (event, xhr, status) ->
    $(this).parent().removeClass('wasnt_fav').addClass('has_fav')

  $(document).on 'ajax:error', ".favory, .unfavory", (event, xhr, status) ->
    alert '操作失败'

  $(document).on 'ajax:success', ".unfavory", (event, xhr, status) ->
    $(this).parent().removeClass('has_fav').addClass('wasnt_fav')
