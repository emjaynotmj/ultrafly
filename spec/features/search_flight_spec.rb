require 'rails_helper'

RSpec.feature 'Search Flight' do

  scenario 'user visits home page' do
    visit root_path
    expect(page).to have_content 'Flights'
    select 'Abuja', from: 'flightFrom'
    select 'Lagos', from: 'flightTo'
    select '2', from: 'passenger'
    fill_in "date-picker", with: Time.zone.now.strftime("%m/%d/%Y")
    click_button "Search Flights"
  end
end