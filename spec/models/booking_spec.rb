require "rails_helper"

RSpec.describe Booking, type: :model do
  subject { build(:booking) }

  it { should be_valid }
  it { should respond_to(:flight_id) }
  it { should respond_to(:total_price) }
  it { should respond_to(:user_id) }
end
