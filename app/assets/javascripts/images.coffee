jQuery(document).on 'turbolinks:load', ->
  # Automatically adjust instagram image height eq its width
  $('.instagram-image').css('height', $('#instagram-section .gallery > div').width())
  $('.project-preview').css('height', $('.project-preview').width()*2/3)
  if window.innerHeight > window.innerWidth
    $('.about-portrait img').addClass('vertical')
