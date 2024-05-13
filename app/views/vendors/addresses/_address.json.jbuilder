json.extract! address, :id, :service_id, :full_address, :district, :province, :phone, :longitude, :latitude, :created_at, :updated_at
json.url address_url(address, format: :json)
