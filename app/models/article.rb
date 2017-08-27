class Article < ApplicationRecord
  belongs_to :blog
  
  enum status: [:draft, :published, :deleted]

  validates :title, presence: true
  validates :content, presence: true
end
