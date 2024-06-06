class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show ]

  # GET /categories/1 or /categories/1.json
  def show
    @services = Service.search(params[:search],
                               district: params[:district],
                               province: params[:province],
                               pricing_from: params[:pricing_from].to_i.zero? ? nil : params[:pricing_from].to_i,
                               pricing_to: params[:pricing_to].to_i.zero? ? nil : params[:pricing_to].to_i,
                               selected_category_id: @category.id)
    custom_count = Service.custom_count(@services.to_sql)

    @pagy, @services = pagy(@services, count: custom_count, items: 10)
  end



  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def search_params
    params.permit(:search, :district, :province, :pricing_from, :pricing_to)
  end

  def category_params
    params.require(:category).permit(:name, :image)
  end
end
