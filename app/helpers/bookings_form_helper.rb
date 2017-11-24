module BookingsFormHelper
  def client_fields(form, booking, client)
    if client
      output = [content_tag(:h3, "with #{client.name}"), hidden_field_tag("booking[client_id]", client.id)]
      safe_join(output)
    else
      render partial: "client_fields", locals: { f: form, booking: booking }
    end
  end
  
  def venue_fields(form, booking, venue)
    if venue 
      output = [content_tag(:h3, "at #{venue.nickname}"), hidden_field_tag("booking[venue_id]", venue.id)]
      safe_join(output)
    else 
      render partial: "venue_fields", locals: { f: form, booking: booking }
    end
  end
  
  def booking_date(booking)
    if booking.booking_time
      booking.booking_time.strftime("%m/%d/%Y")
    else
      Time.zone.now.strftime("%m/%d/%Y")
    end
  end
  
  def hour_selector(name, booking)
    time_choices = {
     "8 AM" => 8, 
     "9 AM" => 9, 
     "10 AM" => 10, 
     "11 AM" => 11, 
     "12 PM" => 12, 
     "1 PM" => 13,
     "2 PM" => 14,
     "3 PM" => 15,
     "4 PM" => 16,
     "5 PM" => 17,
     "6 PM" => 18,
     "7 PM" => 19,
     "8 PM" => 20,
    }
    select_tag(name, options_for_select(time_choices, time_choices[booking_hour(booking)] ) )
  end
  
  def booking_hour(booking)
    if booking.booking_time
      booking.booking_time.strftime('%l %p').strip 
    else
      "8 AM"
    end
  end
  
  def min_selector(name, booking)
    min_choices = ["00", "15", "30", "45"]
    select_tag(name, options_for_select(min_choices, booking_min(booking) ) )
  end 
  
  def booking_min(booking)
    if booking.booking_time
      booking.booking_time.strftime('%M') 
    else
      "00"
    end
  end
  
  def duration_hour_field(name, booking)
    options = {
      "0 hr" => "0",
      "1 hr" => "3600",
      "2 hr" => "7200", 
      "3 hr" => "10800"
    }
    select_tag(name, options_for_select(options, get_duration_hour(booking) ) )
  end
  
  def duration_minute_field(name, booking)
    options = {
      "00 min" => "0",
      "15 min" => "900", 
      "30 min" => "1800", 
      "45 min" => "2700"
    }
    select_tag(name, options_for_select(options, get_duration_min(booking) ) )
  end
  
  def get_duration_hour(booking)
    if booking.duration 
      ((booking.duration/3600)*3600)
    else 
      0
    end
  end
  
  def get_duration_min(booking)
    if booking.duration 
      (booking.duration % 3600)
    else 
      1800
    end
  end
  
  def float_two_decimals(price)
    '%.2f' % price if price
  end
  
  # def parse_time(array)
  #   DateTime.parse(array["date"] + " " + array["hour"] + ":" + array["min"])
  # end
  
end
