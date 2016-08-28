require 'rails_helper'

RSpec.describe User, type: :model do
  # subject(:user) { build(:user)}
  subject { build(:user) }

  it { should be_valid }

  # its(:email) { should == "mujeebjamiu@yahoo.com" }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
end
