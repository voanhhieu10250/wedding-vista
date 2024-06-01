class Vendors::AddressesController < Vendors::BaseController
  before_action :set_service
  before_action :set_address, only: %i[ show edit update destroy ]

  # GET /addresses or /addresses.json
  def index
    @addresses = @service.addresses
  end

  # GET /addresses/1 or /addresses/1.json
  def show; end

  # GET /addresses/new
  def new
    @address = @service.addresses.build
  end

  # GET /addresses/1/edit
  def edit; end

  # POST /addresses or /addresses.json
  def create
    @address = @service.addresses.build(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to vendor_service_address_url(@address.service, @address), notice: "Address was successfully created." }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to vendor_service_address_url(@address.service, @address), notice: "Address was successfully updated." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy!

    respond_to do |format|
      format.html { redirect_to vendor_service_addresses_url(@service), notice: "Address was successfully destroyed." }
      format.json { head :no_content }
    end
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
