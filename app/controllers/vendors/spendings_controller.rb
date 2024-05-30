class Vendors::SpendingsController < Vendors::BaseController
  before_action :set_spending, only: %i[ show ]

  def index
    @spendings = current_vendor.spendings
  end

  def show; end

  def new
    @spending = Spending.new
  end

  # This method is used to create a new spending record.
  # Mainly, it creates a new spending record for post limit.
  # TODO: Need to do validate the amount and limit for the spending record.
  # Create new table for spending limits and prices, so that admin can set the limit and price for each spending.
  def create
    @spending = current_vendor.spendings.build(spending_params.except(:limit).merge(kind: :post_limit))

    if @spending.save
      current_vendor.transaction do
        current_vendor.increment!(:post_limit, spending_params[:limit].to_i, touch: false)
        current_vendor.decrement!(:balance, spending_params[:amount].to_i)
      end

      respond_to do |format|
        format.html { redirect_to vendor_spending_url(@spending), notice: "Spending was successfully created." }
        format.json { render :show, status: :created, location: @spending }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spending.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_spending
    @spending = Spending.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def spending_params
    params.require(:spending).permit(:amount, :limit)
  end
end
