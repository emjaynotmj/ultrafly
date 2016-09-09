FactoryGirl.define do
  factory :flight do
    departure_airport_id 1
    arrival_airport_id 2
    available_seats 9
    departure_date Time.zone.now.strftime("%m/%d/%Y")
    arrival_date Time.zone.tomorrow.strftime("%m/%d/%Y")
    price "9.99"
    airline_name "Aero Contractors"
  end
end
