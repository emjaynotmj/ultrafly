require 'rails_helper'

RSpec.feature "User log in" do
  before(:each) do
    create(:user)
  end

  scenario "should allow a registered user to login" do
    visit root_path
    click_link "Sign In"
    fill_in "user_email", with: "mujeebjamiu@yahoo.com"
    fill_in "user_password", with: "asdfghjkl"
    click_button "Log in"
    expect(page).to have_content "Signed in successfully"
  end
end