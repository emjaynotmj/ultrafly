require "rails_helper"

feature "User books a flight" do
  before { create(:flight) }

  scenario "User Books a Flight", js: true do
    visit root_path
    click_link "All Flights"
    choose "flight_id"
    click_button "Select Flight"
    click_link "Add Passenger"
    fill_in("passenger_name", with: "Emjay")
    fill_in("passenger_email", with: "emjaynoni@yahoo.com")
    click_on "Book Flight"
  end
end
