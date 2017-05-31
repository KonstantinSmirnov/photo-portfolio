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
    $('.calendar').datepicker
      autoclose: true
      format: 'yyyy-mm-dd'
    $("#seo_description_counter").html(170 - $("#seo_description").val().length).append(" characters left")
    $("#seo_description").parents('div.form-group').css("margin-bottom":"0")
    $("#seo_description").on "input", ->
      if $(@).val().length > 0
        if $(@).val().length > 120
          $("#seo_description_counter").css("color":"red")
          $("#seo_description_counter").html(170 - $(@).val().length).append(" characters left")
        else
          $("#seo_description_counter").css("color":"black")
          $("#seo_description_counter").html(170 - $(@).val().length).append(" characters left")
      else
        $("#seo_description_counter").css("color":"black")
    $("#seo_keywords_counter").html(255 - $("#seo_keywords").val().length).append(" characters left")
    $("#seo_keywords").parents('div.form-group').css("margin-bottom":"0")
    $("#seo_keywords").on "input", ->
      if $(@).val().length > 0
        if $(@).val().length > 200
          $("#seo_keywords_counter").css("color":"red")
          $("#seo_keywords_counter").html(255 - $(@).val().length).append(" characters left")
        else
          $("#seo_keywords_counter").css("color":"black")
          $("#seo_keywords_counter").html(255 - $(@).val().length).append(" characters left")
      else
        $("#seo_keywords_counter").css("color":"black")
    $("#seo_text_counter").html($("#seo_text").val().length).append(" characters")
    $("#seo_text").parents('div.form-group').css("margin-bottom":"0")
    $("#seo_text").on "input", ->
      if $(@).val().length > 0
        $("#seo_text_counter").css("color":"black")
        $("#seo_text_counter").html($(@).val().length).append(" characters")
      else
        $("#seo_text_counter").css("color":"black")
        $("#seo_text_counter").html("0 characters")
