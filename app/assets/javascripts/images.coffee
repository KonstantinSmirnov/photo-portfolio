jQuery(document).on 'turbolinks:load', ->
  # Automatically adjust instagram image height eq its width
  $('.instagram-image').css('height', $('#instagram-section .gallery > div').width())
