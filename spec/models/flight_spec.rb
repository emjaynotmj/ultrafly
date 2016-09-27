require "rails_helper"

RSpec.describe Flight, type: :model do
  subject { build(:flight) }

  it { should be_valid }
  it { should respond_to(:departure_airport_id) }
  it { should respond_to(:arrival_airport_id) }
  it { should respond_to(:departure_date) }
end
