class UltraMailer < ApplicationMailer
  default from: "admin@ultrafly.com"

  def self.mail_user(booking, current_user)
    users = Passenger.where(booking_id: booking.id)
    if current_user
      send_mail(current_user.email, booking)
      users.each do |user|
        send_mail(user.email, booking) if user.email != current_user.email
      end
    else
      users.each { |user| send_mail(user.email, booking) }
    end
  end

  def self.send_mail(user, booking)
    booking_confirmed(user, booking).deliver_now!
  end

  def booking_confirmed(email, booking)
    @booking = booking
    mail(to: email, subject: "Your booking has been confirmed")
  end
end
