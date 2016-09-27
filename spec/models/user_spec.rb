require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should be_valid }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
end
