require "rails_helper"

RSpec.describe PaymentsController, type: :routing do
  describe "routing" do
    it "routes to #payment" do
      expect(get: "/payments/1").
        to route_to("payments#payment", flight_id: "1")
    end

    it "routes to #payment_success" do
      expect(get: "/payments").
        to route_to("payments#payment_success")
    end
  end
end
