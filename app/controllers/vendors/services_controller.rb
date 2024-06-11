module Vendors
  class ServicesController < Vendors::BaseController
    before_action :set_service_with_references, only: %i[ show edit ]
    before_action :set_service, only: %i[ update destroy publish unpublish ]
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
        flash[:notice] = "Dịch vụ đã được tạo thành công."
        redirect_to action: :index
      else
        flash_errors_message(@service, now: true)
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /services/1 or /services/1.json
    def update
      if @service.update(service_params)
        flash[:notice] = "Dịch vụ đã được cập nhật."
        redirect_to vendor_service_url(@service)
      else
        flash_errors_message(@service)
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @service.destroy
      flash[:notice] = "Xoá dịch vụ thành công."
      redirect_to vendor_services_url
    end

    def publish
      # Only publish when service has as least 4 items in its galleries
      if @service.first_four_items.present? && @service.first_four_items.size >= 4
        @service.update(published: true)
        flash.now[:notice] = "Dịch vụ đã được bật trạng thái công khai."
      else
        flash.now[:alert] = "Dịch vụ cần ít nhất 4 ảnh để bật trạng thái công khai.<br>Vui lòng thêm ảnh vào dịch vụ."
      end
    end

    def unpublish
      @service.update(published: false)
      flash.now[:notice] = "Dịch vụ đã được bật trạng thái ẩn."
    end

    private

    def service_params
      # Remove commas from the price string
      params[:service][:pricing] = params[:service][:pricing].gsub(",", "") if params[:service][:pricing].present?

      params.require(:service).permit(:name, :description, :pricing, :category_id, :website, :main_address_id,
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
    def set_service_with_references
      @service = current_vendor.services.includes(:category,
                                                  :main_address,
                                                  :common_questions,
                                                  :reviews).find(params[:id])
    end

    def set_service
      @service = current_vendor.services.includes(:category).find(params[:id])
    end

    def set_pagy_services
      services = current_vendor.services.includes(:category)

      if params[:search].present?
        params[:search] = params[:search].strip
        services = services.where("services.name LIKE ?", "%#{params[:search]}%")
      end

      @pagy, @services = pagy services, item: 10
    end
  end
end
