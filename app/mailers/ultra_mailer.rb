class UltraMailer < ApplicationMailer
  default from: "admin@ultrafly.com"

  def self.mail_user(booking, current_user)
    users = Passenger.where(booking_id: booking.id)
    if current_user
      send_mail(booking, current_user.email)
      users.each do |user|
        send_mail(booking, user.email) if user.email != current_user.email
      end
    else
      users.each { |user| send_mail(booking, user.email) }
    end
  end

  def self.send_mail(booking, user_email)
    booking_confirmed(booking, user_email).deliver_now!
  end

  def booking_confirmed(booking, email)
    @booking = booking
    @flight = Flight.find(@booking.flight_id)
    @passengers = Passenger.where(booking_id: @booking.id)
    mail(to: email, subject: "Your booking has been confirmed")
  end
end
