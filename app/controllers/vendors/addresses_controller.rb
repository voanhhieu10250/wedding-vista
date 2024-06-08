class Vendors::AddressesController < Vendors::BaseController
  before_action :set_service, except: %i[ index ]
  before_action :set_address, only: %i[ show edit update destroy ]

  # GET /addresses or /addresses.json
  def index
    @service = current_vendor.services.includes(:addresses).find(params[:service_id])
    @addresses = @service.addresses
  end

  # GET /addresses/1 or /addresses/1.json
  def show
    render :show, layout: false
  end

  # GET /addresses/1/edit
  def edit
    render :edit, layout: false
  end

  # POST /addresses or /addresses.json
  def create
    @address = @service.addresses.build(address_params)

    if @address.save
      flash.now[:notice] = "Address was successfully created."
    else
      flash_errors_message @address, now: true
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    if @address.update(address_params)
      flash.now[:notice] = "Address was successfully updated."
    else
      flash_errors_message @address, now: true
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy!
    flash.now[:notice] = "Address was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_address
    @address = @service.addresses.find(params[:id])
  end

  def set_service
    @service = current_vendor.services.find(params[:service_id])
  end

  # Only allow a list of trusted parameters through.
  def address_params
    params.require(:address).permit(:full_address, :district, :province, :phone, :longitude, :latitude)
  end
end
