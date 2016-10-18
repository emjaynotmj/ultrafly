require "rails_helper"

RSpec.feature "User views past booking records" do
  let(:booking) { create(:booking, :registered_user_booking) }

  scenario "when a registered user checks his past booking records", js: true do
    sign_in(booking.user)
    visit bookings_path

    expect(page).to have_content "Bookings Summary"
    expect(page).to have_content booking.booking_ref_code
  end

  scenario "when an anonymous user checks his past booking records", js: true do
    visit bookings_path

    expect(page).to have_content "sign in or sign up before continuing"
  end
end
