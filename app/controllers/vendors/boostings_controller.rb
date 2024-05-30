class Vendors::BoostingsController < Vendors::BaseController
  before_action :set_priority_boosting, only: %i[ show edit update destroy ]

  # GET /priority_boostings or /priority_boostings.json
  def index
    @priority_boostings = PriorityBoosting.all
  end

  # GET /priority_boostings/1 or /priority_boostings/1.json
  def show; end

  # GET /priority_boostings/new
  def new
    @priority_boosting = PriorityBoosting.new
  end

  # GET /priority_boostings/1/edit
  def edit; end

  # POST /priority_boostings or /priority_boostings.json
  def create
    @priority_boosting = PriorityBoosting.new(priority_boosting_params)

    respond_to do |format|
      if @priority_boosting.save
        format.html do
          redirect_to vendor_boosting_url(@priority_boosting), notice: "Priority boosting was successfully created."
        end
        format.json { render :show, status: :created, location: @priority_boosting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @priority_boosting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /priority_boostings/1 or /priority_boostings/1.json
  def update
    respond_to do |format|
      if @priority_boosting.update(priority_boosting_params)
        format.html do
          redirect_to vendor_boosting_url(@priority_boosting), notice: "Priority boosting was successfully updated."
        end
        format.json { render :show, status: :ok, location: @priority_boosting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @priority_boosting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /priority_boostings/1 or /priority_boostings/1.json
  def destroy
    @priority_boosting.destroy!

    respond_to do |format|
      format.html { redirect_to vendor_boostings_url, notice: "Priority boosting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_priority_boosting
    @priority_boosting = PriorityBoosting.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def priority_boosting_params
    params.require(:priority_boosting).permit(:service_id, :level, :start_time, :end_time, :status)
  end
end
