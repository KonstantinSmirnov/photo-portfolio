# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin, class: 'User' do
    email 'test@test.com'
    password 'password'
    password_confirmation 'password'
  end
end
