require "rails_helper"

RSpec.describe Airport, type: :model do
  subject { create(:airport) }

  describe "#has_many" do
    it { is_expected.to have_many(:arriving_flights) }
    it { is_expected.to have_many(:departing_flights) }
  end

  describe "#validates_presence_of" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:state) }
  end

  context "When a user creates an airport with valid parameters" do
    it { is_expected.to be_valid }
    it { is_expected.to be_persisted }
    its(:name) { is_expected.to eq(Airport.last.name) }
    its(:state) { is_expected.to eq(Airport.last.state) }
  end

  context "When a user creates a flight with missing required parameter(s)" do
    subject { Airport.create(state: "Lagos") }

    it { is_expected.not_to be_valid }
    it { is_expected.not_to be_persisted }
    its(:name) { is_expected.to be_nil }
    its("errors.full_messages") { should include("Name can't be blank") }
  end
end