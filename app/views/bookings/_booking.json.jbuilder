date_format = '%Y-%m-%d'

json.id booking.id
json.title booking.title
json.start booking.start.strftime(date_format)
json.end booking.end.strftime(date_format)

json.color booking.color unless booking.color.blank?

json.update_url booking_path(booking, method: :patch)
json.edit_url edit_booking_path(booking)