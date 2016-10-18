require "rails_helper"

RSpec.feature "User searches past booking records" do
  let(:booking) { create(:booking, :registered_user_booking) }

  scenario "when a registered user search for past booking records", js: true do
    sign_in(booking.user)
    visit search_booking_path
    fill_in "booking_ref_code", with: booking.booking_ref_code
    click_button "Search Bookings"

    expect(page).to have_content "Flight Details"
    expect(page).to have_content "Passengers Details"
  end

  scenario "when a registered user check with wrong reference code", js: true do
    sign_in(booking.user)
    visit search_booking_path
    fill_in "booking_ref_code", with: "123456789"
    click_button "Search Bookings"

    expect(page).to have_content "Booking not found"
  end

  scenario "when an anonymous user search for past booking records", js: true do
    visit search_booking_path

    expect(page).to have_content "sign in or sign up before continuing"
  end
end
