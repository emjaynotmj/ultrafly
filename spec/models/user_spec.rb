require "rails_helper"

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe "#has_many" do
    it { is_expected.to have_many(:bookings) }
  end

  describe "#validates_presence_of" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:encrypted_password) }
  end

  context "When a user with valid parameters is created" do
    it { is_expected.to be_valid }
    it { is_expected.to be_persisted }
    it { is_expected.to be_a(User) }
    its(:email) { is_expected.to eq(User.last.email) }
    its(:encrypted_password) { is_expected.to eq(User.last.encrypted_password) }
  end

  context "When a user with missing(required) parameter is created" do
    subject { User.create(email: "emjaynoni@yahoo.com") }

    it { is_expected.not_to be_valid }
    it { is_expected.not_to be_persisted }
    its(:password) { is_expected.to be_nil }
    its("errors.full_messages") { should include("Password can't be blank") }
  end
end
