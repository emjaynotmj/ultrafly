module ModelHelpers
  module FlightHelper
    def valid_params
      {
        from: flights.first.departure_airport_id,
        to: flights.first.arrival_airport_id,
        departure_date: flights.first.departure_date,
        number_of_passengers: 2
      }
    end

    def invalid_params
      {
        from: flights.first.departure_airport_id,
        to: flights.first.arrival_airport_id,
        departure_date: flights.first.departure_date,
        number_of_passengers: 100
      }
    end
  end
end
