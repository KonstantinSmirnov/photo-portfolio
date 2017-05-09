class Category < ApplicationRecord
  validates :title, presence: true
  belongs_to :portfolio
  has_many :projects
end
