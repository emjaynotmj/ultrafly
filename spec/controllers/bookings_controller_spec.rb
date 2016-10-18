require "rails_helper"
include ControllerHelpers::BookingsHelper

RSpec.describe BookingsController do
  let!(:flight) { create(:flight) }

  describe "GET #new_booking_page" do
    context "when a user visits new booking page after selecting flight" do
      subject { get :new_booking_page, flight_id: 1 }

      it "renders new booking page" do
        is_expected.to render_template(:new_booking_page)
      end
    end

    context "when a user visits new booking page without selecting flight" do
      subject { get :new_booking_page }

      it "redirects user to select a flight" do
        is_expected.to redirect_to(flights_path)
      end
    end
  end

  describe "POST #new_booking_details" do
    context "when the user enters at least one passenger's information" do
      subject { post :new_booking_details, booking: VALID_BOOKING_DETAILS }

      it "redirects user to payment path" do
        should redirect_to payment_path(VALID_BOOKING_DETAILS[:flight_id])
      end
    end

    context "when the user do not enter any passenger's information" do
      subject { post :new_booking_details, booking: INVALID_BOOKING_DETAILS }

      it "redirects user to select a flight" do
        is_expected.to redirect_to(flights_path)
      end
    end
  end

  describe "GET #create_booking" do
    subject { get :create_booking }

    context "when booking is successfully created" do
      before { session[:info] = create_booking_params.deep_stringify_keys }

      it "redirects to the booking show page" do
        is_expected.to redirect_to booking_path(assigns[:booking])
      end

      it "increases bookings count by 1" do
        expect { subject }.to change { Booking.count }.by(1)
      end

      it "sends mail to the passenger" do
        expect { subject }.
          to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context "when booking is not created" do
      it "redirects user to select a flight" do
        is_expected.to redirect_to flights_path
      end
    end
  end

  describe "GET #show" do
    subject { get :show, id: 1 }

    context "when booking record is found" do
      before { create(:booking) }

      it "renders the booking show page" do
        is_expected.to render_template(:show)
      end
    end

    context "when booking record is not found" do
      it "redirects user to select a flight" do
        is_expected.to redirect_to(flights_path)
      end
    end
  end

  describe "GET #index" do
    let(:booking) { create(:booking, :registered_user_booking) }
    subject { get :index }

    context "when a signed-in user visits the index page" do
      before { sign_in(booking.user) }

      it "renders the index page" do
        is_expected.to render_template("index")
      end
    end

    context "when an anonymous user visits the index page" do
      it "redirects user to login page" do
        is_expected.to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #edit" do
    let(:booking) { create(:booking, :registered_user_booking) }
    subject { get :edit, id: booking.id }

    context "when a signed-in user visits the edit-booking page" do
      before { sign_in(booking.user) }

      it "renders the booking edit page" do
        is_expected.to render_template(:edit)
      end
    end

    context "when an anonymous user visits the edit-booking page" do
      it "redirects user to login page" do
        is_expected.to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PUT #update" do
    let(:booking) { create(:booking, :registered_user_booking) }
    before { sign_in(booking.user) }
    subject { put :update, id: booking, booking: VALID_BOOKING_DETAILS }

    context "when the user enters valid update details" do
      before do
        VALID_BOOKING_DETAILS[:passengers_attributes] <<
          {
            name: Faker::Name.name,
            email: Faker::Internet.email
          }
      end

      it "redirects to payment page" do
        is_expected.to redirect_to payment_path(booking.flight_id)
      end
    end

    context "when the user enters invalid update details" do
      before do
        VALID_BOOKING_DETAILS[:passengers_attributes] <<
          {
            name: nil,
            email: Faker::Internet.email
          }
      end

      it "redirects back to the booking edit page" do
        is_expected.to redirect_to edit_booking_path
      end
    end
  end

  describe "GET #search_result" do
    let(:booking) { create(:booking, :registered_user_booking) }
    before { sign_in(booking.user) }

    context "when the booking record is found" do
      subject { get :search_result, booking_ref_code: booking.booking_ref_code }

      it "redirects to the booking show page" do
        is_expected.to redirect_to booking_path(booking)
      end
    end

    context "when the booking record record is not found" do
      subject { get :search_result, booking_ref_code: 123_456_789 }

      it "redirects back to the booking search page" do
        is_expected.to redirect_to search_booking_path
      end
    end
  end

  describe "DELETE #destroy" do
    let(:booking) { create(:booking, :registered_user_booking) }
    subject(:delete_booking_action) { delete :destroy, id: booking.id }

    context "when a registered user deletes a booking record" do
      before { sign_in(booking.user) }

      it "redirects back to all bookings page" do
        is_expected.to redirect_to bookings_path
      end

      it "reduces the booking count by 1" do
        expect { delete_booking_action }.to change { Booking.count }.by(-1)
      end

      it "returns a falsy value when checked in the database" do
        delete :destroy, id: booking.id
        expect(Booking.exists?(booking.id)).to be_falsy
      end
    end

    context "when an anonymous user attempts to deletes a booking record" do
      it "redirects user to login page" do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end
end
