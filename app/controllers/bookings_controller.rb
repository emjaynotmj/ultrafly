class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy, :search, :search_result]

  include PaymentHelper
  include MailerHelper

  def new
    session.delete(:info)
    @booking = Booking.new
    number_of_passengers = params[:number_of_passengers].to_i
    number_of_passengers.times { @booking.passengers.build }
  end

  def create
    params[:payment_type] = "new_booking"
    payment
  end

  def index
    @bookings = current_user.bookings
  end

  def edit
    @selected_flight = @booking.flight
  end

  def show
  end

  def update
    params[:booking][:flight_id] = @booking.flight_id
    if @booking.update(booking_params)
      payment
    else
      redirect_to edit_booking_path(@booking), notice: "Enter all Fields"
    end
  end

  def destroy
    redirect_to bookings_path, notice: "Booking cancelled" if @booking.destroy
  end

  def search_result
    @booking = Booking.find_by(booking_ref_code: params[:booking_ref_code])
    if @booking
      redirect_to booking_path(@booking.id)
    else
      redirect_to search_booking_path, notice: "Booking not found"
    end
  end

  def search
  end

  private

  def booking_params
    params.require(:booking).permit(
      :flight_id,
      :user_id,
      :booking_ref_code,
      :total_price,
      :number_of_passengers,
      passengers_attributes: [:id, :name, :email, :_destroy]
    )
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
