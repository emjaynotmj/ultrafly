class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:search, :index]

  include PaymentHelper
  include MailerHelper

  def new
    session.delete(:info)
    @booking = Booking.new
    number_of_passengers = params[:number_of_passengers].to_i
    number_of_passengers.times { @booking.passengers.build }
  end

  def create
    params[:payment_type] = 'new_booking'
    payment unless verify_passenger_info
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
      verify_passenger_info
    end
  end

  def destroy
    redirect_to bookings_path, notice: 'Booking cancelled.' if @booking.destroy
  end

  def search_result
    @booking = Booking.find_by(booking_ref_code: params[:booking_ref_code])
    render :show
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

  def verify_passenger_info
    if booking_params['passengers_attributes'].nil?
      redirect_to :back, notice: 'Enter all Fields'
    end
  end

  def create_booking
    @booking = Booking.new(session[:info]['booking'])
    @booking.booking_ref_code = params[:token]
    @booking.user_id = current_user.id if current_user
    redirect_to booking_path(@booking), notice: 'payment successful.' if @booking.save
  end

  def search
  end
end