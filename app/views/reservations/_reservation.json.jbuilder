date_format = reservation.all_day_reservation? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'

json.title reservation.name
json.id reservation.id
json.start reservation.start.strftime(date_format)
json.end reservation.end.strftime(date_format)
json.color reservation.color

json.allDay reservation.all_day_reservation? ? true : false

json.update_url reservation_path(reservation, method: :patch)
json.edit_url edit_reservation_path(reservation)
