require "rails_helper"

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe "associations" do
    it { is_expected.to have_many(:bookings) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:encrypted_password) }
  end
end
