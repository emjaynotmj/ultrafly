require "rails_helper"

RSpec.describe BookingsController do
  before(:all) do
    @flight = build(:flight)
    @booking = build(:booking)
  end

  let(:valid_booking_params)  do {
    booking_ref_code: Faker::Code.asin,
    total_price: Faker::Commerce.price,
    flight_id: @flight.id,
    user_id: 1,
    passengers_attributes:
    [
      name: Faker::Name.name,
      email: Faker::Internet.email
    ]
  }
  end

  context "GET #new" do
    it "should render the new template" do
      get :new, flight_id: @flight.id
      expect(response).to render_template(:new)
    end

    it "should respond with status 200" do
      get :new, flight_id: @flight.id
      expect(controller).to respond_with :ok
    end

    it "should assign @booking to a new Booking object" do
      get :new, flight_id: @flight.id
      expect(assigns(:booking)).to be_a_new(Booking)
    end
  end

  context "GET #index" do
    it "returns the list of bookings by the user" do
      get :index
    end
  end
end
