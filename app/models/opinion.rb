class Opinion < ApplicationRecord

  before_create :set_position

  validates :text, presence: true
  validates :author, presence: true
  validates :image, presence: true

  has_attached_file :image, styles: { thumb: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def set_position
    self.position = Opinion.count
  end

end
