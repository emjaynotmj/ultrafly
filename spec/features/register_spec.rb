require "rails_helper"

RSpec.feature "User Registration" do
  scenario "when a user register with valid details", js: true do
    visit root_path
    click_link "Sign Up"
    fill_in "user_email", with: "emjaynoni@yahoo.com"
    fill_in "user_password", with: "qwertyui"
    fill_in "user_password_confirmation", with: "qwertyui"
    click_button "Sign up"

    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "when a user register with empty email", js: true do
    visit root_path
    click_link "Sign Up"
    fill_in "user_email", with: nil
    fill_in "user_password", with: "qwertyui"
    fill_in "user_password_confirmation", with: "qwertyui"
    click_button "Sign up"

    expect(page).to have_content "Email can't be blank"
  end

  scenario "when a user register with empty password", js: true do
    visit root_path
    click_link "Sign Up"
    fill_in "user_email", with: "emjaynoni@yahoo.com"
    fill_in "user_password", with: nil
    fill_in "user_password_confirmation", with: nil
    click_button "Sign up"

    expect(page).to have_content "Password can't be blank"
  end

  scenario "when a the two passwords doesn't match", js: true do
    visit root_path
    click_link "Sign Up"
    fill_in "user_email", with: "emjaynoni@yahoo.com"
    fill_in "user_password", with: "qwertyui"
    fill_in "user_password_confirmation", with: "qwertyui2"
    click_button "Sign up"

    expect(page).to have_content "Please review the problems below:"
  end
end
