jQuery ->
  $(document).on "turbolinks:load ajaxComplete", ->
    $('#categories-list').sortable
      update: ->
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
    $('#opinions-list').sortable
      update: ->
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
    $('#slides-list').sortable
      update: ->
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
    $('#project-photos').sortable
      update: ->
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
