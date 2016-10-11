module ControllerHelpers
  module PaymentsHelper
    def new_booking_payment_details
      {
        token: "123456789",
        payment_type: "new_booking"
      }
    end

    def update_booking_payment_details
      {
        "id" => @booking.id
      }
    end
  end
end
