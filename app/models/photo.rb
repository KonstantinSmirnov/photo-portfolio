class Photo < ApplicationRecord

  before_create :set_position

  validates :alt, presence: true
  validates :image, presence: true

  has_attached_file :image, styles: { cover: "1600x1600>", thumb: "400x400>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  belongs_to :project

  def set_position
    self.position = project.photos.count
  end
end
