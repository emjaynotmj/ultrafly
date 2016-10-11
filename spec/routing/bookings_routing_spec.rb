require "rails_helper"

RSpec.describe BookingsController, type: :routing do
  describe "routing" do
    it "routes to #new_booking_page" do
      expect(get: "/bookings/new").
        to route_to("bookings#new_booking_page")
    end

    it "routes to #new_booking_details" do
      expect(post: "/bookings").
        to route_to("bookings#new_booking_details")
    end

    it "routes to #create_booking" do
      expect(get: "/bookings/create").
        to route_to("bookings#create_booking")
    end

    it "routes to #show" do
      expect(get: "/bookings/1").
        to route_to("bookings#show", id: "1")
    end

    it "routes to #index" do
      expect(get: "/bookings").
        to route_to("bookings#index")
    end

    it "routes to #edit" do
      expect(get: "bookings/1/edit").
        to route_to("bookings#edit", id: "1")
    end

    it "routes to #update" do
      expect(put: "/bookings/1").
        to route_to("bookings#update", id: "1")
    end

    it "routes to #update" do
      expect(patch: "/bookings/1").
        to route_to("bookings#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/bookings/1").
        to route_to("bookings#destroy", id: "1")
    end

    it "routes to #search" do
      expect(get: "/bookings/search").
        to route_to("bookings#search")
    end

    it "routes to #search_result" do
      expect(get: "/bookings/search_result").
        to route_to("bookings#search_result")
    end
  end
end
