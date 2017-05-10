class Setting < ApplicationRecord
  validates :webpage_title, presence: true
  validates_length_of :seo_description, maximum: 170, allow_blank: true
  validates_length_of :seo_keywords, maximum: 255, allow_blank: true
end
