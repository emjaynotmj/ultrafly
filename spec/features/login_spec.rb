require 'rails_helper'

RSpec.feature "User log in" do
  let(:user) { create(:user) }

  scenario "should allow a registered user to login" do
    visit root_path
    click_link "Sign In"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
    expect(page).to have_content "Signed in successfully"
  end
end