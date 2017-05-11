$.fn.wait = (ms, callback) ->
  @each ->
    setTimeout callback.bind(this), ms
    return


jQuery ($) ->
  $(document).on "turbolinks:load ajaxComplete", ->
    $('.textarea-resizable').each( ->
      @.setAttribute 'style', 'height:' + @.scrollHeight + 'px;overflow-y:hidden;'
    ).on 'input', ->
      @.style.height = 'auto'
      @.style.height = @.scrollHeight + 'px'
    $('.btn-processable').on 'click', ->
      $(@).wait 800, ->
        $(this).addClass('btn-processing')
      
