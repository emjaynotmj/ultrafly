module PaymentHelper
  def payment
    payment_service = instantiate_payment_service
    response = payment_service.make_payment
    params[:token] = response.token
    session[:info] = params
    redirect_to response.redirect_uri
  end

  def instantiate_payment_service
    selected_flight = Flight.find(params[:booking][:flight_id])
    PaymentService.new(
      selected_flight: selected_flight,
      validate_url: payment_success_url,
      contact_url: root_url,
      total_cost: params[:booking][:total_price].to_i
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
    mail_user(@booking)
    session.delete(:info)
  end

  def create_booking
    @booking = Booking.new(session[:info]["booking"])
    @booking.booking_ref_code = params[:token]
    @booking.user_id = current_user.id if current_user
    redirect_to(booking_path(@booking), notice: "payment successful") if @booking.save
  end

  private :payment, :instantiate_payment_service, :create_booking
end