# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setting do
    webpage_title "MyString"
    seo_description "MyText"
    seo_keywords "My, text"
    seo_text "MyText"
    contact_phone '+919000'
    contact_email 'test@test.com'
    facebook 'http://test.com'
  end
end
