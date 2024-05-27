class Vendors::TransactionsController < Vendors::BaseController
  before_action :set_payos, only: %i[create success cancel verify_payment]
  before_action :callback_params, only: %i[success cancel]
  skip_before_action :verify_authenticity_token, only: %i[verify_payment]
  skip_before_action :authenticate_vendor!, only: %i[verify_payment]

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
  rescue StandardError => e
    respond_to do |format|
      format.json do
        render_json_error(OpenStruct.new(type: "NotFound", message: e.message), :not_found)
      end
      format.html { render template: "errors/not_found", layout: "application", status: :not_found }
    end
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
  rescue StandardError => e
    respond_to do |format|
      format.json do
        render_json_error(OpenStruct.new(type: "NotFound", message: e.message), :not_found)
      end
      format.html { render template: "errors/not_found", layout: "application", status: :not_found }
    end
  end

  def verify_payment
    data = @payos.verify_payment_webhook_data(params)

    pp data

    if data[:orderCode] < 1000
      render json: { status: "success" }, status: :ok
      return
    end

    # Get the transaction id from the orderCode

    # transaction_id = data[:orderCode].to_s[0..-5].to_i
    # @transaction = Transaction.find(transaction_id)

    # if params[:status] == "PAID" && @transaction.pending?
    #   @transaction.paid!
    #   current_vendor.increment!(:balance, @transaction.amount)
    # elsif params[:status] == "CANCELLED" && @transaction.pending?
    #   @transaction.cancelled!
    # end

    render json: { status: "success" }, status: :ok
  # rescue StandardError => e
  #   respond_to do |format|
  #     format.json do
  #       render_json_error(OpenStruct.new(type: "NotFound", message: e.message), :not_found)
  #     end
  #     format.html { render template: "errors/not_found", layout: "application", status: :not_found }
  #   end
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
