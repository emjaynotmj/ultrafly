class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [
    :index,
    :edit,
    :update,
    :destroy,
    :search,
    :search_result
  ]

  def new_booking_page
    if params[:flight_id]
      session.delete(:info)
      @selected_flight = Flight.find(params[:flight_id])
      @booking = Booking.new
      number_of_passengers = params[:number_of_passengers].to_i
      number_of_passengers.times { @booking.passengers.build }
    else
      redirect_to flights_path, alert: "Please select a flight first"
    end
  end

  def new_booking_details
    if params[:booking][:passengers_attributes].any?
      flight_id = params[:booking][:flight_id]
      session[:info] = { payment_type: "new_booking" }
      session[:info][:booking] = booking_params
      redirect_to payment_path(flight_id)
    else
      redirect_to flights_path, alert: "Please enter the passenger(s) info"
    end
  end

  def create_booking
    if session[:info]
      @booking = Booking.new(session[:info]["booking"])
      @booking.booking_ref_code = session[:info]["token"]
      @booking.user_id = current_user.id if current_user
      @booking.save
      redirect_to(booking_path(@booking), notice: "Payment successful")
      UltraMailer.mail_user(@booking, current_user)
      session.delete(:info)
    else
      redirect_to flights_path, alert: "Error creating your booking"
    end
  end

  def show
    if @booking
      @selected_flight = @booking.flight
      @passengers = Passenger.where(booking_id: @booking.id)
    else
      redirect_to flights_path, alert: "Booking record not found"
    end
  end

  def index
    @bookings = current_user.bookings
  end

  def edit
    @selected_flight = @booking.flight
  end

  def update
    session.delete(:info)
    params[:booking][:flight_id] = @booking.flight_id
    session[:info] = { booking: booking_params }
    session[:info][:id] = params[:id]
    if @booking.update(booking_params)
      redirect_to payment_path(@booking.flight_id)
    else
      redirect_to edit_booking_path(@booking), notice: "Enter all Fields"
    end
  end

  def destroy
    redirect_to bookings_path, notice: "Booking cancelled" if @booking.destroy
  end

  def search
  end

  def search_result
    @booking = Booking.find_by(booking_ref_code: params[:booking_ref_code])
    if @booking
      redirect_to booking_path(@booking.id)
    else
      redirect_to search_booking_path, notice: "Booking not found"
    end
  end

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
    @booking = Booking.find_by_id(params[:id]) if params[:id]
  end

  private :booking_params, :set_booking
end
