class About < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true
  validates :portrait, presence: true
  validates :signature, presence: true

  has_attached_file :portrait, styles: { normal: '1000x1000>', thumb: '300x300>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :portrait, content_type: /\Aimage\/.*\z/

  has_attached_file :signature, styles: { normal: '800x800>', thumb: '300x300>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :signature, content_type: /\Aimage\/.*\z/
end
