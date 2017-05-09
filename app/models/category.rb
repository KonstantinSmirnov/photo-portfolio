class Category < ApplicationRecord
  validates :title, presence: true
  belongs_to :portfolio
end
