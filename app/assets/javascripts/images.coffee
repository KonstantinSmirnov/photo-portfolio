jQuery(document).on 'turbolinks:load', ->
  # Automatically adjust instagram image height eq its width
  $('.instagram-image').css('height', $('#instagram-section .gallery > div').width())

# jQuery(window).on 'load', ->
#   $('.slider-for').find('img').each ->
#       imgClass = if $(this).width / $(this).height > 1 then 'wide' else 'tall'
#       $(this).addClass imgClass
