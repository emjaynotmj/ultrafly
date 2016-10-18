module ControllerHelpers
  module FlightsHelper
    def valid_search_params
      {
        from: flights.second.departure_airport_id,
        to: flights.second.arrival_airport_id,
        number_of_passengers: 2,
        departure_date: flights.second.departure_date
      }
    end

    def invalid_search_params
      {
        from: flights.second.departure_airport_id,
        to: flights.second.arrival_airport_id,
        number_of_passengers: 10,
        departure_date: flights.second.departure_date
      }
    end
  end
end
