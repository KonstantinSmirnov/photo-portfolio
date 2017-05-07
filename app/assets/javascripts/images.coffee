jQuery(document).on 'turbolinks:load', ->
  # Automatically adjust images when resize
  $(window).resize(->
    $('.instagram-image').css('height', $('#instagram-section .gallery > div').width())
    $('.project-preview').css('height', $('.project-preview').width()*2/3)
    if window.innerHeight > window.innerWidth
      $('.about-portrait img').addClass('vertical')
    else
      $('.about-portrait img').removeClass('vertical')
    return
  ).resize()
