FactoryGirl.define do
  factory :flight do
    departure_airport_id 1
    arrival_airport_id 2
    available_seats 9
    departure_date Time.zone.now.strftime("%d/%m/%Y")
    arrival_date Time.zone.tomorrow.strftime("%d/%m/%Y")
    price "9.99"
    airline_name "Aero Contractors"
  end
end
