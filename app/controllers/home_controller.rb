class HomeController < ApplicationController
  def index
    @hero_carousel_slides = HeroCarouselSlide.order(:position)
    @about = About.first
    @projects = Project.order('date DESC')
    if @instagram = Instagram.first
      @last_instagram_fotos = Instagram.first.get_last_posts
    end
    @opinions = Opinion.order(:position)
  end
end
