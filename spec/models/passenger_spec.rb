require "rails_helper"

RSpec.describe Passenger, type: :model do
  subject { create(:passenger) }

  describe "associations" do
    it { is_expected.to belong_to(:booking) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end
end
