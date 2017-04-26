class HomeController < ApplicationController
  def index
    @hero_carousel_slides = HeroCarouselSlide.all
    @about = About.first
    if @instagram = Instagram.first
      @last_instagram_fotos = Instagram.first.get_last_posts
    end
    @contact = Contact.first
  end
end
