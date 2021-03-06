class Project < ApplicationRecord
  validates :title, presence: true
  validates :date, presence: true

  has_many :photos, dependent: :destroy
  belongs_to :portfolio
  belongs_to :category

  def cover_photo
    photos.order(:position).first
  end
end
