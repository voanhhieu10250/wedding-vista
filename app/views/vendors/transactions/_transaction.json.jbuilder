json.extract! transaction, :id, :vendor_id, :description, :amount, :status, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
