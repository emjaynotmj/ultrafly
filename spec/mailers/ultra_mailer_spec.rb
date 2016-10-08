require "rails_helper"

RSpec.describe UltraMailer do
  before(:all) do
    @booking = create(:booking)
  end

  context "send email to users" do
    let(:booking_confirmation) { UltraMailer.mail_user(@booking, @booking.user) }

    it "should increase sent_email count by 2" do
      sign_in(@booking.user)
      expect { booking_confirmation }.to change {
        ActionMailer::Base.deliveries.count
      }.by(2)
    end

    it "should ensure mails were sent this sepcific emails" do
      booking_confirmation
      expect(ActionMailer::Base.deliveries.first.to).to include(@booking.user.email)
      expect(ActionMailer::Base.deliveries.last.to).to include(@booking.passengers.first.email)
    end

    it "should ensure mails were sent with the correct title" do
      booking_confirmation
      expect(ActionMailer::Base.deliveries.first.subject).to eq("Your booking has been confirmed")
    end

    it "should ensure mails were sent with the correct title" do
      booking_confirmation
      expect(ActionMailer::Base.deliveries.first.body).to include("Flight Details")
    end
  end
end