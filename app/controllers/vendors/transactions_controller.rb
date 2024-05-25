class Vendors::TransactionsController < Vendors::BaseController
  before_action :set_payos
  before_action :callback_params, only: %i[success cancel]

  def index
    @transactions = current_vendor.transactions
  end

  def show
    @transaction = Transaction.find(params[:id])
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

      # redirect_to response[:checkoutUrl], allow_other_host: true
      @redirect_url = response[:checkoutUrl]
    else
      flash_errors_message(@transaction, now: true)
      # redirect_to new_vendor_transaction_path
    end
  end

  def success
    # Get payment link information. To check if the payment is successful
    response = @payos.get_payment_link_information(params[:id])

    # remove the last 4 characters from the orderCode to get the transaction id
    transaction_id = response[:orderCode].to_s[0..-5].to_i
    @transaction = Transaction.find(transaction_id)

    # If the payment is successful, update the transaction record in db to have the status PAID
    if response[:status] == "PAID" && @transaction.pending?
      @transaction.paid!
      current_vendor.increment!(:balance, @transaction.amount)
      flash.now[:success] = "Payment was successful"
    else
      flash.now[:error] = "Invalid action"
    end

    render "show"
  end

  def cancel
    response = @payos.get_payment_link_information(params[:id])

    # remove the last 4 characters from the orderCode to get the transaction id
    transaction_id = response[:orderCode].to_s[0..-5].to_i
    @transaction = Transaction.find(transaction_id)

    if response[:status] == "CANCELLED" && @transaction.pending?
      @transaction.cancelled!
      flash.now[:error] = "Payment was cancelled"
    else
      flash.now[:error] = "Invalid action"
    end

    render "show"
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
    params.permit(:code, :id, :cancel, :status, :orderCode)
  end
end
