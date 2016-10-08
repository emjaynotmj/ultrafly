FactoryGirl.define do
  factory :airport do
    sequence(:name, 1) { |n| Faker::Space.agency + n.to_s }
    sequence(:state, 1) { |n| Faker::Address.state + n.to_s }
  end
end
