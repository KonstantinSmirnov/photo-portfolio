jQuery(document).on 'turbolinks:load', ->
  $('#hero-slider').slick({
    dots: false,
    infinite: true,
    fade: true,
    cssEase: 'ease-out',
    autoplay: true,
    autoplaySpeed: 5000
  });
  $('#opinions-section').slick({
    dots: true,
    infinite: true,
    speed: 1000,
    autoplay: true
    });
  $('.project-gallery').slick({
    dots: true;
    infinite: false,
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
    slidesToShow: 1,
    slidesToScroll: 1,
    infinite: false,
    asNavFor: '.slider-for',
    centerMode: true,
    focusOnSelect: true,
    variableWidth: true
  });
