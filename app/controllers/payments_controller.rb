class PaymentsController < ApplicationController
  RETURN_URL = "http://localhost:3000/payment/success"
  CANCEL_URL = "http://localhost:3000/payment/cancel"

  before_action :set_payos, only: %i[create]

  def show; end

  def create
    # TODO: Create a order record in db to have a unique orderCode (order id)

    # Create payment link
    response = @payos.create_payment_link(
      amount: params[:payment][:amount].to_i, # Amount is in VND
      orderCode: params[:payment][:orderCode].to_i, # Order code used here is the order id
      returnUrl: RETURN_URL,
      cancelUrl: CANCEL_URL,
      description: params[:payment][:description]
    )

    redirect_to response[:checkoutUrl], allow_other_host: true
  end

  def success
    # /payment/success?code=00&id=aaec05a76b6a4fab8ba1a6da0d360a1a&cancel=false&status=PAID&orderCode=1234

    render "show"
  end

  def cancel
    # /payment/cancel?code=00&id=b8ba2924a4dc48aebba8506d65c25c05&cancel=true&status=CANCELLED&orderCode=12

    render "show"
  end

  private

  def set_payos
    @payos = PayOS.new
  end

  def payment_params
    params.require(:payment).permit(:orderCode, :amount, :description)
  end
end
