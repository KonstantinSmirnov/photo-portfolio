class Category < ApplicationRecord

  before_create :set_position

  validates :title, presence: true
  belongs_to :portfolio
  has_many :projects

  def set_position
    self.position = Category.count
  end
end
