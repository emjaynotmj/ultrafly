require "rails_helper"

RSpec.feature "Search Flight" do
  before(:all) do
    create_list(:airport, 3)
    create(:flight)
  end

  describe "User search for flights" do
    scenario "visits homepage" do
      visit root_path
      expect(page).to have_content "Online flight reservation just got better!"
    end

    scenario "user selects the same airport for departure and arrival", js: true do
      visit root_path
      select "Nnamdi Azikwe International Airport, Abuja", from: "from"
      select "Nnamdi Azikwe International Airport, Abuja", from: "to"
      fill_in "date-picker", with: Time.zone.now.strftime("%m/%d/%Y")
      select "5", from: "passengers"
      click_button "Search Flights"
      expect(page).to have_content "No Flights found for the specified locations"
      expect(page).not_to have_content "Search results for flights from"
    end

    scenario "user searches for unavailable flights", js: true do
      visit root_path
      select "Nnamdi Azikwe International Airport, Abuja", from: "from"
      select "Alakia Airport, Ibadan", from: "to"
      fill_in "date-picker", with: Time.zone.now.strftime("%m/%d/%Y")
      select "5", from: "passengers"
      click_button "Search Flights"
      expect(page).to have_content "No Flights found for the specified locations"
      expect(page).not_to have_content "Search results for flights from"
    end

    scenario "user selects number_of_passengers greater than available_seats", js: true do
      visit root_path
      select "Nnamdi Azikwe International Airport, Abuja", from: "from"
      select "Akanu Ibiam International Airport, Enugu", from: "to"
      fill_in "date-picker", with: Time.zone.now.strftime("%m/%d/%Y")
      select "10", from: "passengers"
      click_button "Search Flights"
      expect(page).to have_content "No Flights found for the specified locations"
      expect(page).not_to have_content "Search results for flights from"
    end

    scenario "user searches for an available flight", js: true do
      visit root_path
      select "Nnamdi Azikwe International Airport, Abuja", from: "from"
      select "Akanu Ibiam International Airport, Enugu", from: "to"
      fill_in "date-picker", with: Time.zone.now.strftime("%d/%m/%Y")
      select "5", from: "passengers"
      click_button "Search Flights"
      expect(page).to have_content "Search results for flights from"
      expect(page).not_to have_content "No Flights found for the specified locations"
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
      expect(page).to have_content "Your Booking For Flight"
      expect(page).to have_content "Emjay"
      expect(page).to have_content "emjaynoni@yahoo.com"
    end
  end
end
