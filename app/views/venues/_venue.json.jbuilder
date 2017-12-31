json.extract! venue, :id, :name, :price, :byline, :host, :capacity, :street_address, :postcode, :created_at, :updated_at
json.url venue_url(venue, format: :json)
