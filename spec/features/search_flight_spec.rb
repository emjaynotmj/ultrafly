require "rails_helper"

RSpec.feature "Search Flight" do
  before(:all) do
    @flight = create(:flight)
  end

  describe "User search for flights" do
    scenario "visits homepage" do
      visit root_path
      expect(page).to have_content "Online flight reservation just got better!"
    end

    scenario "user selects same airport as departure and arrival", js: true do
      visit root_path
      select @flight.departure_airport.name, from: "from"
      select @flight.departure_airport.name, from: "to"
      fill_in "departure_date", with: DateTime.now.strftime("%Y/%m/%d")
      select "2", from: "number_of_passengers"
      click_button "Search Flights"
      expect(page).to have_content "Departure and Arrival Airport cannot be the same"
    end

    scenario "user searches for unavailable flight_date", js: true do
      visit root_path
      select @flight.departure_airport.name, from: "from"
      select @flight.arrival_airport.name, from: "to"
      fill_in "departure_date", with: Time.zone.tomorrow.tomorrow.strftime("%Y/%m/%d")
      select "2", from: "number_of_passengers"
      click_button "Search Flights"
      expect(page).to have_content "No Flights found"
      expect(page).not_to have_content "Search results for flights from"
    end

    scenario "user selects number_of_passengers > available_seats", js: true do
      visit root_path
      select @flight.departure_airport.name, from: "from"
      select @flight.arrival_airport.name, from: "to"
      fill_in "departure_date", with: DateTime.now.strftime("%Y/%m/%d")
      select "10", from: "number_of_passengers"
      click_button "Search Flights"
      expect(page).to have_content "No Flights found"
      expect(page).not_to have_content "Search results for flights from"
    end

    scenario "user searches for an available flight", js: true do
      visit root_path
      select @flight.departure_airport.name, from: "from"
      select @flight.arrival_airport.name, from: "to"
      fill_in "departure_date", with: Time.zone.now.strftime("%Y/%m/%d")
      select "2", from: "number_of_passengers"
      click_button "Search Flights"
      expect(page).to have_content "Search results for flights from"
      expect(page).not_to have_content "No Flights found"
    end
  end

  describe "User books a flight" do
    scenario "User Book a Flight", js: true do
      visit root_path
      click_link "All Flights"
      choose "flight_id"
      click_button "Select Flight"
      click_link "Add Passenger"
      fill_in("passenger_name", with: "Emjay")
      fill_in("passenger_email", with: "emjaynoni@yahoo.com")
      click_on "Book Flight"
      # sleep 5
      # expect(page).to have_content "PayPal"
    end
  end
end
