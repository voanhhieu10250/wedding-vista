class Vendors::TransactionsController < Vendors::BaseController
  before_action :set_payos, only: %i[create cancel success_callback cancel_callback verify_payment_webhook]
  before_action :callback_params, only: %i[success_callback cancel_callback]

  skip_before_action :verify_authenticity_token, only: %i[verify_payment_webhook]
  skip_before_action :authenticate_vendor!, only: %i[verify_payment_webhook]

  rescue_from StandardError do |error|
    respond_to do |format|
      format.json { render_json_error(OpenStruct.new(type: "NotFound", message: error.message), :not_found) }
      format.html { render template: "errors/not_found", layout: "application", status: :not_found }
    end
  end

  def index
    @transactions = current_vendor.transactions
  end

  def show
    @transaction = current_vendor.transactions.find(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = current_vendor.transactions.build(transaction_params)
    random_number = rand(1000..9999) # Add random number to the orderCode to make it unique

    if @transaction.save
      # Create payment link
      response = @payos.create_payment_link(
        amount: @transaction.amount, # Amount is in VND
        orderCode: "#{@transaction.id}#{random_number}".to_i,
        returnUrl: vendor_payment_success_url,
        cancelUrl: vendor_payment_cancel_url,
        description: "Wedding Vista"
      )

      @transaction.update(checkout_url: response[:checkoutUrl], payment_link_id: response[:paymentLinkId])

      # redirect_to response[:checkoutUrl], allow_other_host: true
      @redirect_url = response[:checkoutUrl]
    else
      flash_errors_message(@transaction, now: true)
      # redirect_to new_vendor_transaction_url
    end
  end

  def cancel
    @transaction = current_vendor.transactions.find(params[:id])

    unless @transaction.cancelled?
      @payos.cancel_payment_link(@transaction.payment_link_id)
      @transaction.cancelled!
      flash.now[:success] = "Payment was cancelled"
    end

    redirect_to vendor_transaction_url(@transaction)
  end

  def success_callback
    unless @transaction.paid?
      # Get payment link information. To check if the payment is successful
      response = @payos.get_payment_link_information(@transaction.payment_link_id)

      # If the payment is successful, update the transaction record in db to have the status PAID
      if response[:status] == "PAID"
        @transaction.paid!
        current_vendor.increment!(:balance, @transaction.amount)
        flash.now[:success] = "Payment was successful"
      end
    end

    render "show"
  end

  def cancel_callback
    unless @transaction.cancelled?
      response = @payos.get_payment_link_information(@transaction.payment_link_id)

      if response[:status] == "CANCELLED"
        @transaction.cancelled!
        flash.now[:error] = "Payment was cancelled"
      end
    end

    render "show"
  end

  # This is the webhook endpoint that PayOS will send the SUCCESSFULL payment to
  def verify_payment_webhook
    data = @payos.verify_payment_webhook_data(params)

    # This is to avoid processing the webhook for test transactions
    if data[:orderCode].to_i < 1000
      render json: { status: "success" }, status: :ok
      return
    end

    # Get the transaction id from the orderCode
    transaction_id = data[:orderCode].to_s[0..-5].to_i
    transaction = Transaction.find_by!(id: transaction_id, payment_link_id: data[:paymentLinkId])

    unless transaction.paid?
      transaction.paid!
      current_vendor.increment!(:balance, transaction.amount)
    end

    render json: { status: "success" }, status: :ok
  end

  private

  def transaction_params
    if params[:transaction][:amount].present?
      params[:transaction][:amount] = params[:transaction][:amount].gsub(",", "")
    end
    params.require(:transaction).permit(:amount)
  end

  def set_payos
    @payos = PayOS.new
  end

  def callback_params
    params.require(%i[orderCode id])

    # remove the last 4 characters from the orderCode to get the transaction id
    transaction_id = params[:orderCode].to_i < 1000 ? params[:orderCode] : params[:orderCode].to_s[0..-5].to_i
    @transaction = Transaction.find_by!(id: transaction_id, payment_link_id: params[:id])
  end
end
