FactoryGirl.define do
  factory :passenger do
    name Faker::Name.name
    email Faker::Internet.email
  end
end
