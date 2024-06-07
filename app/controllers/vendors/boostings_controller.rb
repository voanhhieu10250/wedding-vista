class Vendors::BoostingsController < Vendors::BaseController
  before_action :update_time_params, only: %i[ update ]
  before_action :set_service
  before_action :set_priority_boosting, only: %i[ show destroy edit update ]

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

  def edit
    return unless @priority_boosting.active? || @priority_boosting.expired?

    redirect_to vendor_service_boosting_url(@service, @priority_boosting),
                alert: "You can't edit an active or expired boosting."
  end

  def update
    # if boosting is active or expired then we can't update the level of the boosting
    if @priority_boosting.active? || @priority_boosting.expired?
      redirect_to edit_vendor_service_boosting_url(@service, @priority_boosting),
                  alert: "You can't update the level of an active or expired boosting."
      return
    end

    success = if update_time_params[:now] == "1"
                @priority_boosting.update_times_and_job(Time.zone.now.to_s,
                                                        (Time.zone.now + 1.day).to_s)

              else
                @priority_boosting.update_times_and_job(Time.zone.parse(update_time_params[:start_time]).to_s,
                                                        (Time.zone.parse(update_time_params[:start_time]) + 1.day).to_s,
                                                        create_job: true)
              end

    if success
      redirect_to vendor_service_boosting_url(@service, @priority_boosting),
                  notice: "Priority boosting was successfully updated."
    else
      format.html { render :edit, status: :unprocessable_entity }
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
      priority_boosting_params[:start_time] = Time.zone.parse(priority_boosting_params[:start_time]).to_s
    end

    priority_boosting_params[:end_time] = (Time.zone.parse(priority_boosting_params[:start_time]) + 1.day).to_s
    priority_boosting_params[:level] = priority_boosting_params[:level].to_i

    priority_boosting_params
  end

  def update_time_params
    params.require(:priority_boosting).permit(:start_time, :now)
  end
end
