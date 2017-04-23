class Instagram < ApplicationRecord
  require 'open-uri'

  validates :text, presence: true

  def get_last_posts
    return false if access_token.nil?

    content = open("https://api.instagram.com/v1/users/self/media/recent/?access_token=#{access_token}&count=8").read
    parsed_content = JSON.parse(content)

    posts = []
    parsed_content['data'].each do |item|
      p item['link']
      posts << [ image: item['images']['low_resolution']['url'], link: item['link']]
    end

    return posts
  end
end
