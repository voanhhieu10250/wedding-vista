json.extract! spending, :id, :vendor_id, :amount, :type, :created_at, :updated_at
json.url vendor_spending_url(spending, format: :json)
