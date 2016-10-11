require "rails_helper"
include ControllerHelpers::PaymentsHelper

RSpec.describe PaymentsController do
  before(:all) do
    @booking = create(:booking)
  end

  context "GET #payment_success" do
    it "should redirect to create_booking_path" do
      get :payment_success,
          session[:info] = new_booking_payment_details.stringify_keys,
          token: "123456789"
      expect(response).to redirect_to(:create_booking)
    end

    it "should find the booking and redirect to its show page" do
      get :payment_success,
          session[:info] = update_booking_payment_details
      expect(ActionMailer::Base.deliveries.count).to be > 0
      expect(response).to redirect_to(booking_path(@booking))
    end
  end
end