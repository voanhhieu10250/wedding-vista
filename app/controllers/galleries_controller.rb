class GalleriesController < ApplicationController
  before_action :set_service
  before_action :set_gallery, only: %i[ show ]

  def index
    @galleries = @service.galleries
  end

  def show; end

  private

  def set_service
    @service = Service.includes(:galleries).find_by!(id: params[:service_id], published: true)
  end

  def set_gallery
    @gallery = @service.galleries.find(params[:id])
  end
end
