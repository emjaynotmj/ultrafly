class UltraMailer < ApplicationMailer
  default from: 'admin@ultrafly.com'

  def booking_confirmed(email, booking)
    @booking = booking
    mail(to: email, subject: 'Booking Confirmed')
  end
end