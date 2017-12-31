json.array! @bookings do |booking|
  date_format = '%Y-%m-%dT%H:%M:%S'
  json.name booking.name
  
  json.start booking.start.strftime(date_format)
  json.end booking.end.strftime(date_format)
  json.update_url booking_path(booking, method: :patch)
  json.edit_url edit_booking_path(booking)
end