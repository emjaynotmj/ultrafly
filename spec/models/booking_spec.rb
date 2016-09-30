require "rails_helper"

RSpec.describe Booking, type: :model do
  before(:all) do
    @booking = build(:booking)
  end

  context "New Booking object" do
    it "should be valid" do
      expect(@booking).to be_valid
    end

    it "should belong to a flight" do
      expect(@booking).to respond_to(:flight)
    end

    it "should belong to a user" do
      expect(@booking).to respond_to(:user)
    end

    it "should have a total price" do
      expect(@booking).to respond_to(:total_price)
    end

    it "should have a reference code" do
      expect(@booking).to respond_to(:booking_ref_code)
    end

    it "should have many passengers" do
      expect(@booking).to respond_to(:passengers)
    end

    it "should return the flight" do
      expect(@booking.flight).to be_a(Flight)
    end
  end

  context "Associations" do
    it "should belong to flight" do
      expect(@booking).to belong_to(:flight)
    end

    it "should belong to a user" do
      expect(@booking).to belong_to(:user)
    end

    it "should have many passengers" do
      expect(@booking).to have_many(:passengers)
    end

    it "should accept nested passengers attributes" do
      expect(@booking).to accept_nested_attributes_for(:passengers)
    end
  end
end
