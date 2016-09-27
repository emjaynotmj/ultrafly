require "rails_helper"

RSpec.describe Passenger, type: :model do
  subject { build(:passenger) }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:booking_id) }
end
