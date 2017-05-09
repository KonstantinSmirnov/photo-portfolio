class Portfolio < ApplicationRecord
  validates :title, presence: true
  validates :home_title, presence: true
  validates :description, presence: true

  has_many :projects, dependent: :destroy
  has_many :categories, dependent: :destroy

  def categories_with_projects
    categories.select { |c| c.projects.any? }
  end
end
