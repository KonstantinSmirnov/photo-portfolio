class HeroCarouselSlide < ApplicationRecord

  before_create :set_position

  validates :title, length: { minimum: 1, maximum: 50 }
  validates :subtitle, length: { minimum: 1, maximum: 70 }
  validates :image, presence: true

  has_attached_file :image, styles: { cover: "2000x2000>", thumb: "400x400>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def set_position
    self.position = HeroCarouselSlide.count
  end
end
