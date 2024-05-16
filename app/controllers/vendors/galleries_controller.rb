class Vendors::GalleriesController < Vendors::BaseController
  before_action :set_gallery, only: %i[ show edit update destroy ]
  before_action :set_service

  # GET /galleries or /galleries.json
  def index
    @galleries = Gallery.all
  end

  # GET /galleries/1 or /galleries/1.json
  def show; end

  # GET /galleries/new
  def new
    @gallery = Gallery.new
  end

  # GET /galleries/1/edit
  def edit; end

  # POST /galleries or /galleries.json
  def create
    @gallery = @service.galleries.create(gallery_params)

    respond_to do |format|
      if @gallery.save
        format.html do
          redirect_to vendor_service_gallery_url(params[:service_id], @gallery),
                      notice: "Gallery was successfully created."
        end
        format.json { render :show, status: :created, location: @gallery }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galleries/1 or /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html do
          redirect_to vendor_service_gallery_url(params[:service_id], @gallery),
                      notice: "Gallery was successfully updated."
        end
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1 or /galleries/1.json
  def destroy
    @gallery.destroy!

    respond_to do |format|
      format.html { redirect_to vendor_service_galleries_url, notice: "Gallery was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gallery
    @gallery = Gallery.find(params[:id])
  end

  def set_service
    @service = Service.find(params[:service_id])
  end

  # Only allow a list of trusted parameters through.
  def gallery_params
    params.require(:gallery).permit(:name, items: [])
  end
end
