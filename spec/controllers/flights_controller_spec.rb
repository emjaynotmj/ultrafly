require "rails_helper"
include ControllerHelpers::FlightsHelper

RSpec.describe FlightsController do
  describe "POST #search" do
    let!(:flights) { create_list(:flight, 3) }

    context "when one or more available flights are found" do
      subject { xhr :post, :search, valid_search_params }

      it { expect(Flight.count).to eq(3) }
      it { expect(Flight.search(valid_search_params).count).to eq(1) }
      it "returns the search result with flights" do
        xhr :post, :search, valid_search_params
        expect(assigns(:flights)).not_to be_empty
        expect(assigns(:flights).count).to eq(1)
      end
    end

    context "when the search result is empty" do
      subject { xhr :post, :search, invalid_search_params }

      it { expect(Flight.count).to eq(3) }
      it { expect(Flight.search(invalid_search_params)).to be_empty }
      it "returns an empty search result" do
        xhr :post, :search, invalid_search_params
        expect(assigns(:flights)).to be_empty
      end
    end
  end

  describe "GET #index" do
    subject { get :index }

    context "when there are available flights" do
      let!(:flights) { create_list(:flight, 3) }

      it { expect(Flight.count).to eq(3) }
      it { expect(Flight.available_flights.count).to eq(3) }
      it "returns a list of available flights" do
        get :index
        expect(assigns(:flights).count).to eq(3)
      end
    end

    context "when there is no available flight" do
      it { expect(Flight.available_flights).to be_empty }
      it "returns no flight" do
        get :index
        expect(assigns(:flights)).to be_empty
      end
    end
  end
end
