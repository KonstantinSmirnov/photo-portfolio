# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setting do
    webpage_title "MyString"
    seo_description "MyText"
    seo_keywords "My, text"
    seo_text "MyText"
  end
end
