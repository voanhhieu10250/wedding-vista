class ServicesController < ApplicationController
  before_action :set_service, only: %i[ show ]

  # GET /services or /services.json
  def index
    @services = Service.search(params[:search], district: params[:district], province: params[:province])
    custom_count = Service.custom_count(@services.to_sql)

    @pagy, @services = pagy(@services, count: custom_count, items: 10)
  end

  # GET /services/1 or /services/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    # The bang method (!) will raise an ActiveRecord::RecordNotFound exception if the record is not found
    @service = Service.includes(:category, :main_address, :common_questions).find_by!(id: params[:id], published: true)
  end

  # Only allow a list of trusted parameters through.
  def service_params
    params.require(:service).permit(:name, :description, :pricing)
  end
end
