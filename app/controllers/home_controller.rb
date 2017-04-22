class HomeController < ApplicationController
  def index
    @hero_carousel_slides = HeroCarouselSlide.all
  end
end
