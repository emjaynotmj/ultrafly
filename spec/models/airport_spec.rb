require "rails_helper"

RSpec.describe Airport, type: :model do
  before(:all) do
    @airport = build(:airport)
  end

    it "should have a valid factory" do
      expect(@airport).to be_valid
    end

    it "should have a name" do
      expect(@airport).to respond_to(:name)
    end

    it "should have a state" do
      expect(@airport).to respond_to(:state)
    end

    it "should have many departing flights" do
      expect(@airport).to have_many(:departing_flights)
    end

    it "should have many arriving flights" do
      expect(@airport).to have_many(:arriving_flights)
    end
end
