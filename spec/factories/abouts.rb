# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :about do
    title "MyString"
    text "MyText"
    portrait { File.new(Rails.root.join('public', 'images', 'test_image.png')) }
    signature { File.new(Rails.root.join('public', 'images', 'test_image.png')) }
  end
end
