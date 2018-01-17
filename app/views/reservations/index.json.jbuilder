json.array! @reservations do |reservation|
  date_format = reservation.all_day_reservation? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  json.date reservation.date
  json.title reservation.name
  json.start reservation.start.strftime(date_format)
  json.end reservation.end.strftime(date_format)
  json.allDay reservation.all_day_reservation? ? true : false
  json.update_url venue_reservation_path(@venue,reservation, method: :patch)
  json.edit_url edit_venue_reservation_path(@venue,reservation)
end
