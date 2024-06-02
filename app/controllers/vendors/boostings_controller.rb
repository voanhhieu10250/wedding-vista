class Vendors::BoostingsController < Vendors::BaseController
  before_action :set_service
  before_action :set_priority_boosting, only: %i[ show edit update destroy ]

  # GET /priority_boostings or /priority_boostings.json
  def index
    @priority_boostings = @service.priority_boostings.order(created_at: :desc)
  end

  # GET /priority_boostings/1 or /priority_boostings/1.json
  def show; end

  # GET /priority_boostings/new
  def new
    @priority_boosting = @service.priority_boostings.build
  end

  # GET /priority_boostings/1/edit
  def edit; end

  # Nếu service đó đã có boosting thì sẽ check level của boosting đó,
  # nếu level của boosting đó lớn hơn level của boosting mới thì không cho tạo level mới
  def create
    unless @service.published?
      redirect_to new_vendor_service_boosting_url(@service),
                  alert: "You can't create a new boosting for an unpublished service."
      return
    end

    if @service.highest_active_boosting_level >= priority_boosting_params[:level].to_i
      redirect_to new_vendor_service_boosting_url(@service),
                  alert: "You can't create a new boosting with the same or lower level than the current active boosting."
      return
    end

    @priority_boosting = @service.priority_boostings.build(priority_boosting_params.except(:now))

    respond_to do |format|
      if @priority_boosting.save
        format.html do
          redirect_to vendor_service_boosting_url(@service, @priority_boosting),
                      notice: "Priority boosting was successfully created."
        end
      else
        format.html { render :new, status: :unprocessable_entity }
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
      format.html { redirect_to vendor_service_boostings_url, notice: "Priority boosting was successfully destroyed." }
    end
  end

  private

  def set_service
    @service = current_vendor.services.find(params[:service_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_priority_boosting
    @priority_boosting = @service.priority_boostings.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def priority_boosting_params
    # Convert start_time and end_time to UTC
    priority_boosting_params = params.require(:priority_boosting).permit(:level, :start_time, :now)

    if priority_boosting_params[:now] == "1"
      priority_boosting_params[:status] = "ACTIVE"
      priority_boosting_params[:start_time] = Time.zone.now.to_s
    else
      priority_boosting_params[:start_time] = Time.zone.parse(priority_boosting_params[:start_time]).utc.to_s
    end

    priority_boosting_params[:end_time] = (Time.zone.parse(priority_boosting_params[:start_time]).utc + 1.day).to_s
    priority_boosting_params[:level] = priority_boosting_params[:level].to_i

    priority_boosting_params
  end
end
