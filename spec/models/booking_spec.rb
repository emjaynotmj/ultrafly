require "rails_helper"

RSpec.describe Booking, type: :model do
  subject { create(:booking) }

  describe "#belongs_to" do
    it { is_expected.to belong_to(:flight) }
    it { is_expected.to belong_to(:user) }
  end

  describe "#has_many" do
    it { is_expected.to have_many(:passengers) }
  end

  describe "#accepts_nested_attributes_for" do
    it { is_expected.to accept_nested_attributes_for(:passengers) }
  end

  describe "#validates_presence_of" do
    it { is_expected.to validate_presence_of(:booking_ref_code) }
    it { is_expected.to validate_presence_of(:flight_id) }
    it { is_expected.to validate_presence_of(:total_price) }
  end

  context "When a user creates a booking with valid parameters" do
    it { is_expected.to be_valid }
    it(:flight) { is_expected.to be_valid }
    it { is_expected.to be_persisted }
    it(:flight) { is_expected.to be_persisted }
    it { is_expected.to be_a(Booking) }
    its(:flight) { is_expected.to be_a(Flight) }
    its(:booking_ref_code) { is_expected.to eq(Booking.last.booking_ref_code) }
    its(:flight_id) { is_expected.to eq(Booking.last.flight_id) }
    its(:total_price) { is_expected.to eq(Booking.last.total_price) }
    its("passengers.first.name") { is_expected.to eq(Passenger.first.name) }
    its("passengers.first.email") { is_expected.to eq(Passenger.first.email) }
  end

  context "When a user creates a booking with missing required parameter(s)" do
    subject { Booking.create(booking_ref_code: "ABCD1234", total_price: 45) }

    it { is_expected.not_to be_valid }
    it { is_expected.not_to be_persisted }
    its(:flight_id) { is_expected.to be_nil }
    its("passengers.first") { is_expected.to be_nil }
    its("errors.full_messages") { should include("Flight can't be blank") }
  end

  context "When a registered user creates a valid booking" do
    subject { create(:booking, :registered_user_booking) }

    its(:user) { is_expected.to be_valid }
    its(:user) { is_expected.to be_persisted }
    its(:user) { is_expected.to be_a(User) }
    its("user.email") { is_expected.to eq(User.last.email) }
    it { is_expected.to be_valid }
  end

  context "When an anonymous user creates a valid booking" do
    subject { create(:booking, :anonymous_booking) }

    its(:user) { is_expected.to be_nil }
    its(:user) { is_expected.not_to be_present }
    its(:user) { is_expected.not_to be_a(User) }
    it { is_expected.to be_valid }
  end
end