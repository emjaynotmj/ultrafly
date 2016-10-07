class PaymentsController < ApplicationController
  def payment
    payment_service = instantiate_payment_service
    response = payment_service.make_payment
    session[:info]["token"] = response.token
    redirect_to response.redirect_uri
  end

  def instantiate_payment_service
    selected_flight = Flight.find(params[:flight_id])
    PaymentService.new(
      selected_flight: selected_flight,
      validate_url: payment_success_url,
      contact_url: root_url,
      total_cost: session[:info]["booking"]["total_price"].to_i
    )
  end

  def payment_success
    if (session[:info]["token"] == params[:token]) &&
       (session[:info]["payment_type"] == "new_booking")
      create_booking
    else
      @booking = Booking.find(session[:info]["id"])
      redirect_to booking_path(@booking), notice: "Your update was successful."
    end
    UltraMailer.mail_user(@booking, current_user)
    session.delete(:info)
  end

  def create_booking
    @booking = Booking.new(session[:info]["booking"])
    @booking.booking_ref_code = params[:token]
    @booking.user_id = current_user.id if current_user
    redirect_to(booking_path(@booking), notice: "Payment successful") if @booking.save
  end

  private :instantiate_payment_service, :create_booking
end
