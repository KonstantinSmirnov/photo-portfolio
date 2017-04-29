class Photo < ApplicationRecord

  validates :alt, presence: true
  validates :image, presence: true

  has_attached_file :image, styles: { cover: "2000x2000>", thumb: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  belongs_to :project
end
