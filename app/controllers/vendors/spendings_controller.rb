class Vendors::SpendingsController < Vendors::BaseController
  before_action :set_spending, only: %i[ show update destroy ]

  # GET /spendings or /spendings.json
  def index
    @spendings = current_vendor.spendings
  end

  # GET /spendings/1 or /spendings/1.json
  def show; end

  # GET /spendings/new
  def new
    @spending = Spending.new
  end

  # POST /spendings or /spendings.json
  def create
    @spending = current_vendor.spendings.build(spending_params.except(:limit).merge(kind: :post_limit))

    respond_to do |format|
      if @spending.save
        current_vendor.increment!(:post_limit, spending_params[:limit].to_i)
        current_vendor.decrement!(:balance, spending_params[:amount].to_i)
        current_vendor.save
        format.html { redirect_to vendor_spending_url(@spending), notice: "Spending was successfully created." }
        format.json { render :show, status: :created, location: @spending }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spending.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spendings/1 or /spendings/1.json
  def update
    respond_to do |format|
      if @spending.update(spending_params)
        format.html { redirect_to vendor_spending_url(@spending), notice: "Spending was successfully updated." }
        format.json { render :show, status: :ok, location: @spending }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spending.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spendings/1 or /spendings/1.json
  def destroy
    @spending.destroy!

    respond_to do |format|
      format.html { redirect_to vendor_spendings_url, notice: "Spending was successfully destroyed." }
      format.json { head :no_content }
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
