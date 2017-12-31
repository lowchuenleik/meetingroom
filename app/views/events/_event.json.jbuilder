json.extract! event, :id, :title, :description, :created_at, :updated_at
json.start event.start_time
json.end event.end_time
json.url event_url(event, format: :html)
