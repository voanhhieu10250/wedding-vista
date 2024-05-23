class Vendors::TransactionsController < Vendors::BaseController
  RETURN_URL = "http://localhost:3000/payment/success"
  CANCEL_URL = "http://localhost:3000/payment/cancel"

  before_action :set_payos
  before_action :callback_params, only: %i[success cancel]

  def index
    @transactions = current_vendor.transactions
  end

  def show; end

  def new; end

  def create
    transaction_params[:description] = "Nap #{transaction_params[:amount]}VND Wedding Vista"
    transaction = current_vendor.transactions.build(transaction_params)

    if transaction.save
      # Create payment link
      response = @payos.create_payment_link(
        amount: transaction.amount, # Amount is in VND
        orderCode: transaction.id, # Order code used here is the transaction id
        returnUrl: RETURN_URL,
        cancelUrl: CANCEL_URL,
        description: transaction.description
      )

      redirect_to response[:checkoutUrl], allow_other_host: true
    else
      flash_errors_message(transaction, now: true)
      render :new, status: :unprocessable_entity
    end
  end

  def success
    # /payment/success?code=00&id=aaec05a76b6a4fab8ba1a6da0d360a1a&cancel=false&status=PAID&orderCode=1234

    # Get payment link information. To check if the payment is successful
    response = @payos.get_payment_link_information(params[:id])

    # If the payment is successful, update the transaction record in db to have the status PAID

    # Else, update the transaction record in db to have the status CANCELLED

    render "show"
  end

  def cancel
    # /payment/cancel?code=00&id=b8ba2924a4dc48aebba8506d65c25c05&cancel=true&status=CANCELLED&orderCode=12

    render "show"
  end

  private

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:amount)
  end

  def set_payos
    @payos = PayOS.new
  end

  def callback_params
    params.permit(:code, :id, :cancel, :status, :orderCode)
  end
end
