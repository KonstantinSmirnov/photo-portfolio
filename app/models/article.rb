class Article < ApplicationRecord
  belongs_to :blog

  validates :title, presence: true
  validates :content, presence: true
end
