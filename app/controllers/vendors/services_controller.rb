module Vendors
  class ServicesController < Vendors::BaseController
    before_action :set_service, only: %i[ show edit update destroy publish unpublish ]
    before_action :set_pagy_services, only: %i[ index search ]

    def index; end

    def search; end

    # GET /services/1 or /services/1.json
    def show; end

    # GET /services/new
    def new
      @service = Service.new
    end

    # GET /services/1/edit
    def edit; end

    def create
      @service = current_vendor.services.build(service_params)

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

    def destroy
      @service.destroy
      flash[:notice] = "Service was successfully destroyed."
      redirect_to vendor_services_path
    end

    def publish
      @service.update(published: true)
      flash.now[:notice] = "Service was successfully published."
    end

    def unpublish
      @service.update(published: false)
      flash.now[:notice] = "Service was successfully unpublished."
    end

    private

    def service_params
      # Remove commas from the price string
      params[:service][:pricing] = params[:service][:pricing].gsub(",", "") if params[:service][:pricing].present?

      params.require(:service).permit(:name, :description, :pricing, :category_id, :published,
                                      addresses_attributes: %i[
                                        id
                                        full_address
                                        district
                                        province
                                        phone
                                        longitude
                                        latitude
                                        _destroy
                                      ])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = current_vendor.services.find(params[:id])
    end

    def set_pagy_services
      services = current_vendor.services.includes(:category)

      if params[:search].present?
        params[:search] = params[:search].strip
        services = services.where("services.name LIKE ?", "%#{params[:search]}%")
      end

      @pagy, @services = pagy_countless services, item: 10
    end
  end
end
