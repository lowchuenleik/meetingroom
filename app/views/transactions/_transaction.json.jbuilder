json.extract! transaction, :id, :user_id, :merchant_id, :venue_id, :total, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
