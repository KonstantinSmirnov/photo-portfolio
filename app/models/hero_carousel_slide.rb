class HeroCarouselSlide < ApplicationRecord

  validates :title, length: { minimum: 1, maximum: 10 }
  validates :subtitle, length: { minimum: 1, maximum: 20 }
end
