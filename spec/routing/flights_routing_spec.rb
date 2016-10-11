require "rails_helper"

RSpec.describe FlightsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/flights").
        to route_to("flights#index")
    end

    it "routes to #search" do
      expect(post: "/flights/search").
        to route_to("flights#search")
    end
  end
end
