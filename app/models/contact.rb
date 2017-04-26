class Contact < ApplicationRecord

  validates :text, presence: true
  validates :image, presence: true

  has_attached_file :image, styles: { normal: "1000x1000>", thumb: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
