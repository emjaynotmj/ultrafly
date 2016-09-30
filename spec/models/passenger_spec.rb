require "rails_helper"

RSpec.describe Passenger, type: :model do
  before(:all) do
    @passenger = build(:passenger)
  end

    it "should have a valid factory" do
      expect(@passenger).to be_valid
    end

    it "should have a name" do
      expect(@passenger).to respond_to(:name)
    end

    it "should have a state" do
      expect(@passenger).to respond_to(:email)
    end

    it "should belong to bookings" do
      expect(@passenger).to belong_to(:booking)
    end
end
