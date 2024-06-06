class ServicesController < ApplicationController
  before_action :set_service, only: %i[ show ]
  before_action :search_params, only: %i[ index ]

  # GET /services or /services.json
  def index
    @services = Service.search(params[:search],
                               district: params[:district],
                               province: params[:province],
                               pricing_from: params[:pricing_from].to_i.zero? ? nil : params[:pricing_from].to_i,
                               pricing_to: params[:pricing_to].to_i.zero? ? nil : params[:pricing_to].to_i)
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
  def search_params
    params.permit(:search, :district, :province, :pricing_from, :pricing_to)
  end
end
