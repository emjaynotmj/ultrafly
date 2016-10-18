require "rails_helper"
include ModelHelpers::FlightHelper

RSpec.describe Flight, type: :model do
  subject { create(:flight) }
  let!(:flights) { create_list(:flight, 3) }
  let!(:departed_flight) { create(:flight, :departed) }

  describe "associations" do
    it { is_expected.to belong_to(:arrival_airport) }
    it { is_expected.to belong_to(:departure_airport) }
    it { is_expected.to have_many(:bookings) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:airline_name) }
    it { is_expected.to validate_presence_of(:arrival_airport_id) }
    it { is_expected.to validate_presence_of(:arrival_date) }
    it { is_expected.to validate_presence_of(:available_seats) }
    it { is_expected.to validate_presence_of(:departure_airport_id) }
    it { is_expected.to validate_presence_of(:departure_date) }
    it { is_expected.to validate_presence_of(:flight_code) }
    it { is_expected.to validate_presence_of(:price) }
  end

  describe ".available_flights" do
    it { expect(Flight.available_flights.count).to eq(3) }
    it { expect(Flight.available_flights).to include(flights.first) }
    it { expect(Flight.available_flights).not_to include(departed_flight) }
  end

  describe ".search" do
    context "When search params matches one or more available flights" do
      it { expect(Flight.search(valid_params).count).to eq(1) }
      it { expect(Flight.search(valid_params)).to include(flights.first) }
      it { expect(Flight.search(valid_params)).not_to include(departed_flight) }
    end

    context "When search params matches no available flight" do
      it { expect(Flight.search(invalid_params).count).to eq(0) }
      it { expect(Flight.search(invalid_params)).not_to include(flights.first) }
      it { expect(Flight.search(invalid_params)).to be_empty }
    end
  end

  describe ".sort_by_departure_date" do
    it { expect(Flight.sort_by_departure_date.first).to eq(departed_flight) }
    it { expect(Flight.sort_by_departure_date.fourth).to eq(flights.third) }
    it { expect(Flight.sort_by_departure_date.count).to eq(4) }
  end
end
