# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :opinion do
    text 'MyText'
    author 'Author'
    image { File.new(Rails.root.join('public', 'images', 'test_image.png')) }
  end
end
