class PaymentService
  def initialize(options)
    @selected_flight = options[:selected_flight]
    @validate_url = options[:validate_url]
    @contact_url = options[:contact_url]
    @total_cost = options[:total_cost]
  end

  def make_payment
    request = Paypal::Express::Request.new(paypal_request_params)
    payment_request = Paypal::Payment::Request.new(payment_request_params)
    request_paypal_payment(request, payment_request)
  end

  private

  def paypal_options
    {
      no_shipping: true,
      allow_note: false,
      pay_on_paypal: true
    }
  end

  def paypal_request_params
    {
      username: "abdulmujeeb.jamiu-facilitator_api1.andela.com",
      password: "2N4HT7JQ8G65JVWY",
      signature: "AFcWxV21C7fd0v3bYYYRCpSSRl31A9X.40ffeKZ.vcGUBaVzZfVwVxtN"
    }
  end

  def payment_request_params
    {
      description: "Payment for Flight Booking at ultrafly.com",
      quantity: 1,
      amount: @total_cost,
      custom_fields: {
        CARTBORDERCOLOR: "C00000",
        LOGOIMG: "http://clipartbest.com//cliparts/McL/oaR/McLoaRqca.svg"
      }
    }
  end

  def request_paypal_payment(request, payment_request)
    request.setup(
      payment_request,
      @validate_url,
      @contact_url,
      paypal_options
    )
  end
end
