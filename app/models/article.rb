class Article < ApplicationRecord
  belongs_to :blog

  enum status: %i[draft published deleted]

  validates :title, presence: true
  validates :content, presence: true

  before_update do
    self.publication_date = Date.today if status == 'published' && status_changed?
    self.publication_date = nil if status != 'published'
  end
end
