FactoryGirl.define do
  factory :flight do
    flight_code { Faker::Code.asin }
    departure_airport_id { create(:airport).id }
    arrival_airport_id { create(:airport).id }
    available_seats { Faker::Number.between(3, 9) }
    departure_date Time.zone.tomorrow.strftime("%d/%m/%Y")
    arrival_date Time.zone.tomorrow.tomorrow.strftime("%d/%m/%Y")
    price { Faker::Commerce.price }
    airline_name { Faker::Space.company }

    trait(:departed) do
      departure_date Time.zone.now.strftime("%d/%m/%Y")
    end
  end
end
