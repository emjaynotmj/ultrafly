FactoryGirl.define do
  factory :booking do
    booking_ref_code { Faker::Code.asin }
    total_price { Faker::Commerce.price }
    flight
    passengers_attributes do
      [
        {
          name: Faker::Name.name,
          email: Faker::Internet.email
        },

        {
          name: Faker::Name.name,
          email: Faker::Internet.email
        }
      ]
    end
  end

  trait :registered_user_booking do
    user
  end

  trait :anonymous_booking do
    user nil
  end
end