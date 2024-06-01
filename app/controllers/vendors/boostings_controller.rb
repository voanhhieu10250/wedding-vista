class Vendors::BoostingsController < Vendors::BaseController
  before_action :set_priority_boosting, only: %i[ show edit update destroy ]
  before_action :set_service, only: %i[ create update ]

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

  # Nếu service đó đã có boosting thì sẽ check level của boosting đó,
  # nếu level của boosting đó lớn hơn level của boosting mới thì không cho tạo level mới
  def create
    if @service.highest_active_boosting_level >= @priority_boosting.level
      redirect_to new_vendor_boosting_url(@service),
                  alert: "You can't create a new boosting with the same or lower level than the current active boosting."
      return
    end

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

  # Chỉ cho update các Boosting đang ở trạng thái pending
  # Chỉ cho update start_time (end_time cũng sẽ được cập nhật lại là start_time + 1.day)
  def update
    # respond_to do |format|
    #   if @priority_boosting.update(priority_boosting_params)
    #     format.html do
    #       redirect_to vendor_boosting_url(@priority_boosting), notice: "Priority boosting was successfully updated."
    #     end
    #     format.json { render :show, status: :ok, location: @priority_boosting }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @priority_boosting.errors, status: :unprocessable_entity }
    #   end
    # end
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

  def set_service
    @service = current_vendor.services.find(params[:service_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_priority_boosting
    @priority_boosting = PriorityBoosting.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def priority_boosting_params
    params.require(:priority_boosting).permit(:level, :start_time, :end_time, :now)
  end
end
