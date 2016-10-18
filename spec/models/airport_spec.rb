require "rails_helper"

RSpec.describe Airport, type: :model do
  subject { create(:airport) }

  describe "associations" do
    it { is_expected.to have_many(:arriving_flights) }
    it { is_expected.to have_many(:departing_flights) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:state) }
  end
end
