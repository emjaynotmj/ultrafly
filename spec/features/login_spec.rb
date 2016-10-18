require "rails_helper"

RSpec.feature "User log in" do
  let(:user) { create(:user) }

  scenario "when a user login with valid details", js: true do
    visit root_path
    click_link "Sign In"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"

    expect(page).to have_content "Signed in successfully"
  end

  scenario "when a user login with wrong email", js: true do
    visit root_path
    click_link "Sign In"
    fill_in "user_email", with: "emjaynoni@yahoo.com"
    fill_in "user_password", with: user.password
    click_button "Log in"

    expect(page).to have_content "Invalid Email"
  end

  scenario "when a user login with wrong password", js: true do
    visit root_path
    click_link "Sign In"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "my_password"
    click_button "Log in"

    expect(page).to have_content "Invalid Email or password"
  end

  scenario "when a user login with wrong email and password", js: true do
    visit root_path
    click_link "Sign In"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "my_password"
    click_button "Log in"

    expect(page).to have_content "Invalid Email or password"
  end
end
