require "rails_helper"

RSpec.feature "Search Flight" do
  let!(:flight) { create(:flight) }

  feature "User search for flights" do
    scenario "visits homepage" do
      visit root_path
      expect(page).to have_content "Online flight reservation just got better!"
    end

    scenario "when user selects same airport as departure/arrival", js: true do
      visit root_path
      select flight.departure_airport.name, from: "from"
      select flight.departure_airport.name, from: "to"
      fill_in "departure_date", with: DateTime.now.strftime("%Y/%m/%d")
      select "2", from: "number_of_passengers"

      click_button "Search Flights"
      expect(page).to have_content "Departure and Arrival Airport cannot be the"
    end

    scenario "when user searches for unavailable flight_date", js: true do
      visit root_path
      select flight.departure_airport.name, from: "from"
      select flight.arrival_airport.name, from: "to"
      fill_in "departure_date",
              with: Time.zone.tomorrow.tomorrow.strftime("%Y/%m/%d")
      select "2", from: "number_of_passengers"
      click_button "Search Flights"

      expect(page).to have_content "No Flights found"
      expect(page).not_to have_content "Search results for flights from"
    end

    scenario "when user selects no_of_passengers > available_seats", js: true do
      visit root_path
      select flight.departure_airport.name, from: "from"
      select flight.arrival_airport.name, from: "to"
      fill_in "departure_date", with: DateTime.now.strftime("%Y/%m/%d")
      select "10", from: "number_of_passengers"
      click_button "Search Flights"

      expect(page).to have_content "No Flights found"
      expect(page).not_to have_content "Search results for flights from"
    end

    scenario "user searches for an available flight", js: true do
      visit root_path
      select flight.departure_airport.name, from: "from"
      select flight.arrival_airport.name, from: "to"
      fill_in "departure_date", with: Time.zone.now.strftime("%Y/%m/%d")
      select "2", from: "number_of_passengers"
      click_button "Search Flights"

      expect(page).to have_content "Search results for flights from"
      expect(page).not_to have_content "No Flights found"
    end
  end
end
