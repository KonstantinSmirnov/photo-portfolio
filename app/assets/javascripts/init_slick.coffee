jQuery(document).on 'turbolinks:load', ->
  $('#hero-slider').slick({
    dots: true,
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
