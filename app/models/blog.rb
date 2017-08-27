class Blog < ApplicationRecord
  validates :title, presence: true
  
  has_many :articles, dependent: :destroy
end
