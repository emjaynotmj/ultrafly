require "rails_helper"

RSpec.describe UltraMailer do
  describe "#mail_user" do
    let(:booking) { create(:booking) }

    context "when mail messages are delivered" do
      subject!(:booking_mail) { UltraMailer.mail_user(booking, booking.user) }

      it "sends mail to the passengers" do
        expect(ActionMailer::Base.deliveries.last.to).
          to include(booking.passengers.last.email)
      end

      it "ensures mails were sent with the correct title" do
        expect(ActionMailer::Base.deliveries.first.subject).
          to eq("Your booking has been confirmed")
      end

      it "ensures mails were sent with the correct body" do
        expect(ActionMailer::Base.deliveries.first.body).
          to include("Flight Details")
      end
    end

    context "when mail messages are not delivered" do
      it "returns an empty array of messages" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end

    context "when a registered_user makes a booking" do
      let(:user_booking) { create(:booking, :registered_user_booking) }
      before { sign_in(user_booking.user) }
      subject(:booking_mail) do
        UltraMailer.mail_user(user_booking, user_booking.user)
      end

      it "sends mail to all passengers and the user" do
        expect { booking_mail }.to change {
          ActionMailer::Base.deliveries.count
        }.by(3)
      end

      it "sends mail to the user also" do
        booking_mail
        expect(ActionMailer::Base.deliveries.first.to).
          to include(user_booking.user.email)
      end
    end

    context "when a anonymous user makes a booking" do
      subject(:booking_mail) { UltraMailer.mail_user(booking, booking.user) }

      it "sends mail to all passengers only" do
        expect { booking_mail }.to change {
          ActionMailer::Base.deliveries.count
        }.by(2)
      end

      it { expect(booking.user).to be_nil }
    end
  end
end
