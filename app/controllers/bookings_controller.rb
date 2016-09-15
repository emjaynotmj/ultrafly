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
      if booking_params['passengers_attributes'].nil?
        format.html { redirect_to :back,  notice: 'You must have at least one passenger'}
      elsif @booking.save
        mail_user(@booking)
        format.html { redirect_to booking_path(@booking.id), notice: 'Flight Booked Successfuly.' }
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

  def mail_user(booking)
    users = Passenger.where(booking_id: booking.id)
    if current_user
      send_mail(current_user.email, booking)
      users.each do |user|
        send_mail(user.email, booking) if user.email != current_user.email
      end
    else
      users.each do |user|
        send_mail(user.email, booking)
      end
    end
  end

  def send_mail(user, booking)
    UltraMailer.booking_confirmed(user, booking, current_user).deliver_now!
  end

  def past_bookings
    unless current_user
      redirect_to root_path
    else
      user = current_user.id if current_user
      @bookings = Booking.where(user_id: user)
    end
  end
end