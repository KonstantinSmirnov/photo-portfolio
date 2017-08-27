class Article < ApplicationRecord
  require 'translit'
  
  before_validation :create_slug
  before_validation :update_publication_date
  
  belongs_to :blog

  enum status: %i[draft published deleted]

  validates :title, presence: true
  validates :content, presence: true

  private 
  
  def create_slug
    self.slug = Translit.convert(self.title, :english)
    self.slug = self.slug.downcase.gsub(/[^0-9a-z]/i, '_')
  end
  
  def update_publication_date
    self.publication_date = Date.today if status == 'published' && status_changed?
    self.publication_date = nil if status != 'published'
  end

end
