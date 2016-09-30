require "rails_helper"

RSpec.describe User, type: :model do
  before(:all) do
    @user = build(:user)
    build(:booking)
  end

  it "should have a valid factory" do
    expect(@user).to be_valid
  end

  it "should have an email" do
    expect(@user).to respond_to(:email)
  end

  it "should have a password" do
    expect(@user).to respond_to(:password)
  end

  it "should have many bookings" do
    expect(@user).to have_many(:bookings)
  end
end
