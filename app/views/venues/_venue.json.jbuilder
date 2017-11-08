json.extract! venue, :id, :name, :price, :created_at, :updated_at
json.url venue_url(venue, format: :json)
