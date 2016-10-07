require "rails_helper"

RSpec.describe FlightsController do
  before(:all) do
    @flights = create_list(:flight, 3)
  end
  let(:valid_search_params) do
    {
      from: @flights.second.departure_airport_id,
      to: @flights.second.arrival_airport_id,
      number_of_passengers: 2,
      departure_date: @flights.second.departure_date
    }
  end

  context "POST #search" do
    it "result should not be empty" do
      xhr :post, :search, valid_search_params
      expect(assigns(@found_flights)).not_to be_empty
    end

    it "render the proper template" do
      xhr :post, :search, valid_search_params
      expect(response).to render_template("search")
    end
  end

  context "GET #index" do
    it "result should not be empty" do
      get :index
      expect(assigns(@available_flights)).not_to be_empty
    end

    it "render the proper template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
