class FlightsController < ApplicationController
  def index
    @flights = Flight.available_flights
  end

  def search
    @flights = Flight.search(search_params)
  end

  def search_params
    params.permit(:from, :to, :departure_date, :number_of_passengers)
  end

  private :search_params
end
