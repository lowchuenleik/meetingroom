json.extract! merchant, :id, :uid, :provider, :access_code, :publishable_key, :created_at, :updated_at
json.url merchant_url(merchant, format: :json)
