module ControllerHelpers
  module BookingsHelper
    VALID_BOOKING_DETAILS =
      {
        booking_ref_code: Faker::Code.asin,
        total_price: Faker::Commerce.price,
        flight_id: 1,
        user_id: 1,
        passengers_attributes: [
          {
            name: Faker::Name.name,
            email: Faker::Internet.email
          }
        ]
      }.freeze

    def create_booking_params
      {
        booking: {
          flight_id: @flight.id,
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
      }
    end
  end
end
