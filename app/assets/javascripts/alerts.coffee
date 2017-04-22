jQuery(document).on "turbolinks:load ajaxComplete", ->
  $('.flash-alert').delay(3000).fadeOut("slow")
