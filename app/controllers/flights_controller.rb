class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  def search
    @flights = Flight.search(
      params[:from].to_i,
      params[:to].to_i,
      params[:date],
      params[:passengers].to_i
    )
  end
end