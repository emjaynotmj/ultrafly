require "rails_helper"

RSpec.describe Passenger, type: :model do
  subject { create(:passenger) }

  describe "#belongs_to" do
    it { is_expected.to belong_to(:booking) }
  end

  describe "#validates_presence_of" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end

  context "When a user creates a passenger with valid parameters" do
    it { is_expected.to be_valid }
    it { is_expected.to be_persisted }
    it { is_expected.to be_a(Passenger) }
    its(:name) { is_expected.to eq(Passenger.last.name) }
    its(:email) { is_expected.to eq(Passenger.last.email) }
  end

  context "When a user creates a passenger with missing required parameter" do
    subject { Passenger.create(name: "Bill Gate") }

    it { is_expected.not_to be_valid }
    it { is_expected.not_to be_persisted }
    its(:email) { is_expected.to be_nil }
    its("errors.full_messages") { should include("Email can't be blank") }
  end
end
