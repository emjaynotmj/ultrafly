require "rails_helper"

RSpec.feature "User logs out" do
  let(:user) { create(:user) }

  scenario "when a user clicks the sign out link", js: true do
    sign_in(user)
    visit root_path
    click_link "My Account"
    click_link "Sign Out"

    expect(page).to have_content "Signed out successfully"
  end
end
