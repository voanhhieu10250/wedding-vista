class Vendors::BoostingsController < Vendors::BaseController
  before_action :set_service
  before_action :set_priority_boosting, only: %i[ show destroy ]

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

  # Nếu service đó đã có boosting thì sẽ check level của boosting đó,
  # nếu level của boosting đó lớn hơn level của boosting mới thì không cho tạo level mới
  def create
    unless @service.published?
      redirect_to new_vendor_service_boosting_url(@service),
                  alert: "You can't create a new boosting for an unpublished service."
      return
    end

    if @service.highest_active_boosting_level > priority_boosting_params[:level].to_i
      redirect_to new_vendor_service_boosting_url(@service),
                  alert: "You can't create a new boosting with the same or lower level than the current active boosting."
      return
    end

    @priority_boosting = @service.priority_boostings.build(priority_boosting_params.except(:now, :amount))

    if @priority_boosting.save
      current_vendor.transaction do
        current_vendor.decrement!(:balance, priority_boosting_params[:amount].to_i)
      end

      redirect_to vendor_service_boosting_url(@service, @priority_boosting),
                  notice: "Priority boosting was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

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
    priority_boosting_params = params.require(:priority_boosting).permit(:level, :start_time, :now, :amount)

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
