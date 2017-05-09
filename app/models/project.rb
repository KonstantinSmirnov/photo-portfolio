class Project < ApplicationRecord

  validates :title, presence: true

  has_many :photos, dependent: :destroy
  belongs_to :portfolio
  belongs_to :category
end
