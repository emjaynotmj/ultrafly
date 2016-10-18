module ControllerHelpers
  module PaymentsHelper
    PAYMENT_PARAMS =
      {
        booking: {
          flight_id: 1,
          total_price: 44,
          passengers_attributes:
            {
              367_634_897 =>
              {
                name: Faker::Name.name,
                email: Faker::Internet.email
              }
            }
        },
        token: Faker::Code.asin.to_s
      }.freeze

    def new_booking_payment_details
      {
        token: "123456789",
        payment_type: "new_booking"
      }
    end

    def update_booking_payment_details
      {
        "id" => 1
      }
    end
  end
end
