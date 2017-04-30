jQuery(document).on 'turbolinks:load', ->
  $('#hero-slider').slick({
    dots: false,
    infinite: true,
    speed: 2000,
    fade: true,
    cssEase: 'ease-out',
    autoplay: true,
    autoplaySpeed: 2000
  });
  $('#opinions-section').slick({
    dots: true,
    infinite: true,
    speed: 1000,
    autoplay: true
    });
  $('.project-gallery').slick({
    dots: true;
    infinite: true,
    slidesToShow: 5,
    slidesToScroll: 5,
    variableWidth: true
    });
  $('.slider-for').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    fade: true,
    asNavFor: '.slider-nav'
  });
  $('.slider-nav').slick({
    slidesToShow: 5,
    slidesToScroll: 1,
    infinite: true,
    asNavFor: '.slider-for',
    #dots: true,
    centerMode: true,
    focusOnSelect: true,
    variableWidth: true
  });
