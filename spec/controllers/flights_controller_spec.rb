require "rails_helper"
include ControllerHelpers::FlightsHelper

RSpec.describe FlightsController do
  before(:all) do
    @flights = create_list(:flight, 3)
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
