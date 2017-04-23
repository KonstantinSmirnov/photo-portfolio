class HomeController < ApplicationController
  def index
    @hero_carousel_slides = HeroCarouselSlide.all
    @about = About.first
  end
end
