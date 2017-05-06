// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.remotipart
//= require tether
//= require bootstrap-sprockets
//= require jquery.slick
//= require jquery_ujs
//= require turbolinks
//= require viewportchecker
//= require_tree .

// делаем хак для мобильных устройств Apple
if (navigator.platform == 'iPad' || navigator.platform == 'iPhone' || navigator.platform == 'iPod')
    {

      // вешаем хэндлер на скролл
      window.onscroll = function()
      {
        // высчитываем значение текущей прокрутки позиции
        var iPadPosition = window.pageYOffset;

        // изменяем фиксированное позиционирование на абсолютное
        $(".about-portrait").css("position", "absolute");

       //  изменяем значение позиционирования от верха
        $(".about-portrait").css("top", iPadPosition);
      };

      // вешаем хэндлер на прикосновение пальцем к экрану
      window.ontouchstart = function ()
      {
        // возвращаем фиксированное позиционирование
        $(".about-portrait").css("position", "fixed");
        // возвращаем значение позиционирования от верха
        $(".about-portrait").css("top", "0");
      };

      // вешаем хэндлер на "убирание" пальца с экрана
      window.ontouchend = function () {
        // возвращаем фиксированное позиционирование
        $(".about-portrait").css("position", "fixed");
      };
    }
