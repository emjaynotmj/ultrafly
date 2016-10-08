require "rails_helper"

RSpec.feature "User Registration" do
  scenario "a guest visitor should be able to register", js: true do
    visit root_path
    click_link "Sign Up"
    fill_in "user_email", with: "emjaynoni@yahoo.com"
    fill_in "user_password", with: "olawale"
    fill_in "user_password_confirmation", with: "olawale"
    click_button "Sign up"
    expect(page).to have_content "Welcome! You have signed up successfully."
  end
end
