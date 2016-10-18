class PaymentsController < ApplicationController
  def payment
    if params[:flight_id] && session[:info]
      payment_service = instantiate_payment_service
      response = payment_service.make_payment
      session[:info]["token"] = response.token
      redirect_to(response.redirect_uri)
    else
      redirect_to root_path, alert: "Your Booking information is required"
    end
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
      redirect_to create_booking_path
    else
      @booking = Booking.find(session[:info]["id"])
      UltraMailer.mail_user(@booking, current_user)
      session.delete(:info)
      redirect_to booking_path(@booking), notice: "Your update was successful."
    end
  end

  private :instantiate_payment_service
end
