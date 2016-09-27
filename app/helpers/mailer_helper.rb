module MailerHelper
  def mail_user(booking)
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

  def send_mail(user, booking)
    UltraMailer.booking_confirmed(user, booking).deliver_now!
  end
end
