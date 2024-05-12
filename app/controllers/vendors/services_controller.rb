module Vendors
  class ServicesController < Vendors::BaseController
    before_action :set_service, only: %i[ show edit update ]

    # GET /services or /services.json
    def index
      @services = Service.all
    end

    # GET /services/1 or /services/1.json
    def show; end

    # GET /services/new
    def new
      @service = Service.new
    end

    # GET /services/1/edit
    def edit; end

    def create
      @service = current_vendor.services.create(service_params)

      if @service.save
        flash[:notice] = "Service was successfully created."
        redirect_to action: :index
      else
        flash_errors_message(@service, now: true)
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /services/1 or /services/1.json
    def update
      if @service.update(service_params)
        flash[:notice] = "Service was successfully updated."
      else
        flash_errors_message(@service)
      end

      redirect_to vendor_service_path(@service)
    end

    private

    def service_params
      params.require(:service).permit(:name, :description, :pricing)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end
  end
end
