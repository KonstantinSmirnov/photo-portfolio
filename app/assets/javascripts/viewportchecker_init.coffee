jQuery(document).on 'turbolinks:load', ->
  $('#about-me-section .description').addClass('hidden').viewportChecker({
    classToAdd: 'visible animated fadeInRight',
    offset: 100
  });

  $('#recent-projects-section .project-preview.left').addClass('hidden').viewportChecker({
    classToAdd: 'visible animated fadeInLeft',
    offset: 100
  });
  $('#recent-projects-section .project-preview.right').addClass('hidden').viewportChecker({
    classToAdd: 'visible animated fadeInRight',
    offset: 100
  });

  $('#instagram-section .capture').addClass('hidden').viewportChecker({
    classToAdd: 'visible animated zoomIn',
    offset: 100
    });
  $('#instagram-section .gallery').addClass('hidden').viewportChecker({
    classToAdd: 'visible animated zoomIn',
    offset: 100
    });
