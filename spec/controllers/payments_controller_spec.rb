require "rails_helper"
include ControllerHelpers::PaymentsHelper

RSpec.describe PaymentsController do
  let!(:flight) { create(:flight) }

  describe "GET #payment" do
    subject { get :payment, flight_id: 1 }

    context "when payment details are valid" do
      let!(:paypal_response) do
        session[:info] = PAYMENT_PARAMS.deep_stringify_keys
        paypal_construct = Struct.new(:token, :redirect_uri)
        paypal_construct.new("TOKEN", "http://paypal.com")
      end

      before do
        allow_any_instance_of(PaymentService).to receive(:make_payment).
          and_return(paypal_response)
      end

      it { is_expected.to redirect_to(paypal_response.redirect_uri) }
      it { is_expected.to have_http_status(302) }
    end

    context "when payment details are invalid" do
      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to have_http_status(302) }
    end
  end

  describe "GET #payment_success" do
    context "when it is a new booking payment" do
      before { session[:info] = new_booking_payment_details.stringify_keys }
      subject { get :payment_success, token: "123456789" }

      it { is_expected.to redirect_to(:create_booking) }
    end

    context "when paying for an updated booking" do
      before do
        create(:booking)
        session[:info] = { "id" => 1 }
      end

      subject { get :payment_success }

      it { is_expected.to redirect_to booking_path(1) }
    end
  end
end
