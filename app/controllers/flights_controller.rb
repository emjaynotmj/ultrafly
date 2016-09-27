class FlightsController < ApplicationController
  def index
    current_time = DateTime.tomorrow
    @flights = Flight.where('departure_date >= ?', current_time)
                     .order('departure_date')
  end

  def search
    @flights = Flight.search(
      params[:from].to_i,
      params[:to].to_i,
      params[:departure_date],
      params[:number_of_passengers].to_i
    )
  end
end