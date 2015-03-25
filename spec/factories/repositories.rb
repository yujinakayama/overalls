FactoryGirl.define do
  factory :repository do
    name { Faker::App.name }
    namespace { Faker::Internet.user_name }
  end
end
