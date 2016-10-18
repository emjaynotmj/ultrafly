require "rails_helper"

RSpec.describe Booking, type: :model do
  subject { create(:booking) }

  describe "associations" do
    it { is_expected.to belong_to(:flight) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:passengers) }
    it { is_expected.to accept_nested_attributes_for(:passengers) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:booking_ref_code) }
    it { is_expected.to validate_presence_of(:flight_id) }
    it { is_expected.to validate_presence_of(:total_price) }
  end
end
