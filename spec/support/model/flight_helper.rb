module ModelHelpers
  module FlightHelper
    def valid_search_params
      {
        from: @flights[0].departure_airport_id,
        to: @flights[0].arrival_airport_id,
        departure_date: @flights[0].departure_date,
        number_of_passengers: 2
      }
    end

    def invalid_search_params
      {
        from: @flights[0].departure_airport_id,
        to: @flights[0].arrival_airport_id,
        departure_date: @flights[0].departure_date,
        number_of_passengers: 100
      }
    end
  end
end
