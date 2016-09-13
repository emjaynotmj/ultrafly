class UltraMailer < ApplicationMailer
  default from: "admin@ultrafly.com"

  def booking_confirmed(email, booking, current_user)
    @booking = booking
      mail(to: email, subject: 'Booking Confirmed' )
  end
end
