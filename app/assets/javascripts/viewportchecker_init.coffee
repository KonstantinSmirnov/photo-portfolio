jQuery(document).on 'turbolinks:load', ->
  $('#about-me-section .description h2').addClass('hidden').viewportChecker({
    classToAdd: 'visible magictime slideUpReturn',
    offset: 100
  });
  $('#about-me-section .description p').addClass('hidden').viewportChecker({
    classToAdd: 'visible magictime slideRightReturn',
    offset: 100
  });
  $('#about-me-section .description img').addClass('hidden').viewportChecker({
    classToAdd: 'visible magictime slideDownReturn',
    offset: 100
  });

  $('#projects-section .project-preview').addClass('hidden').viewportChecker({
    classToAdd: 'visible magictime vanishIn',
    offset: 100
  });
  # $('#recent-projects-section .project-preview.right').addClass('hidden').viewportChecker({
  #   classToAdd: 'visible animated fadeInRight',
  #   offset: 100
  # });

  $('#instagram-section .capture').addClass('hidden').viewportChecker({
    classToAdd: 'visible magictime slideUpReturn',
    offset: 100
    });
  $('#instagram-section .gallery img').addClass('hidden').viewportChecker({
    classToAdd: 'visible magictime perspectiveRightReturn',
    offset: 100
    });
