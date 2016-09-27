require "rails_helper"

RSpec.describe Airport, type: :model do
  subject { build(:airport) }

  it { should be_valid }
  it { should respond_to(:name) }
end
