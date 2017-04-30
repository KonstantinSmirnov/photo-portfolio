class Project < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true

  has_many :photos, dependent: :destroy
  belongs_to :portfolio
end
