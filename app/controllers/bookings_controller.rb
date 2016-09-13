class BookingsController < ApplicationController
  def new
    @selected_flight = Flight.find(params[:flight_id])
    @booking = Booking.new
    no_of_passengers = params[:no_of_passengers].to_i
    no_of_passengers.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    respond_to do |format|
      if @booking.save
        format.html { redirect_to booking_path(@booking.id), notice: 'Flight Booked Successfuly.' }
      else
        format.html { redirect_to :back,  notice: 'You must have at least one passenger'}
      end
    end
  end

  def booking_params
    params.require(:booking).permit(:flight_id, :user_id, :booking_ref_code,
      passengers_attributes:[:id,:name, :email,:_destroy])
  end

  def show
    @booking = Booking.find(params[:id])
  end
end