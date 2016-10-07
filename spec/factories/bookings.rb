FactoryGirl.define do
  factory :booking do
    booking_ref_code { Faker::Code.asin }
    total_price { Faker::Commerce.price }
    flight
    user
    passengers_attributes do
      [
        name: Faker::Name.name,
        email: Faker::Internet.email
      ]
    end
  end
end
