require "rails_helper"

RSpec.describe Flight, type: :model do
  before(:all) do
    @flights = create_list(:flight, 3)
    @flights[3] = create(:flight, :departed)
  end

  let(:valid_search_params) do
    {
      from: @flights[0].departure_airport_id,
      to: @flights[0].arrival_airport_id,
      departure_date: @flights[0].departure_date,
      number_of_passengers: 2
    }
  end

  let(:invalid_search_params) do
    {
      from: @flights[0].departure_airport_id,
      to: @flights[0].arrival_airport_id,
      departure_date: @flights[0].departure_date,
      number_of_passengers: 100
    }
  end

  context "Association #A flight" do
    it "should belong to a arrival airport" do
      expect(@flights[0]).to belong_to(:arrival_airport)
    end

    it "should belong to a departure airport" do
      expect(@flights[0]).to belong_to(:departure_airport)
    end

    it "should have many bookings" do
      expect(@flights[0]).to have_many(:bookings)
    end
  end

  context "Attributes #A flight" do
    it "should have an airline" do
      expect(@flights[0]).to respond_to(:airline_name)
    end

    it "should have an arrival airport" do
      expect(@flights[0]).to respond_to(:arrival_airport)
    end

    it "should have an arrival date" do
      expect(@flights[0]).to respond_to(:arrival_date)
    end

    it "should have a number of available seats" do
      expect(@flights[0]).to respond_to(:available_seats)
    end

    it "should have a departure airport" do
      expect(@flights[0]).to respond_to(:departure_airport)
    end

    it "should have a departure date" do
      expect(@flights[0]).to respond_to(:departure_date)
    end

    it "should have a code" do
      expect(@flights[0]).to respond_to(:flight_code)
    end

    it "should have a price" do
      expect(@flights[0]).to respond_to(:price)
    end
  end

  context "Class Methods #The Flight class method" do
    it ".available_flights should return the list of available flights" do
      expect(Flight.available_flights).to include(@flights[0], @flights[1], @flights[2])
    end

    it ".available_flights should return the list of available flights" do
      expect(Flight.available_flights).to_not include(@flights[3])
    end

    it ".search should return the flight search results" do
      expect(Flight.search(valid_search_params)).to include(@flights[0])
    end

    it ".search should return the flight search results without the departed flight" do
      expect(Flight.search(valid_search_params)).not_to include(@flights[3])
    end

    it ".search should return no available flights" do
      expect(Flight.search(invalid_search_params)).to be_empty
    end

    it ".sort_by_departure_date should return flights sorted by departure_date in ascending order" do
      expect(Flight.sort_by_departure_date).to eq([@flights[3], @flights[0], @flights[1], @flights[2]])
    end

    it ".sort_by_departure_date should return flights sorted by departure_date in ascending order" do
      expect(Flight.sort_by_departure_date.first).to eq(@flights[3])
    end
  end
end
