require "rails_helper"

RSpec.describe BookingsController do
  before(:all) do
    @flight = create(:flight)
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


end