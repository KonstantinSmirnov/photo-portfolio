jQuery(document).on 'turbolinks:load', ->
  # Automatically adjust images when resize
  $(window).resize(->
    $('.instagram-image').css('height', $('#instagram-section .gallery > div').width())
    $('.project-preview').css('height', $('.project-preview').width()*2/3)
    if window.innerHeight > window.innerWidth
      $('#hero-slider img').addClass('vertical')
      $('#about-me-section .about-portrait img').addClass('vertical')
      $('#about-me-section .description').removeClass('offset-md-5')
    else
      $('#hero-slider img').removeClass('vertical')
      $('.about-portrait img').removeClass('vertical')
      $('#about-me-section .description').addClass('offset-md-5')
    return
  ).resize()
