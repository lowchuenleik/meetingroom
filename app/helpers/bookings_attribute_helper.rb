module BookingsAttributeHelper
  def full_time(booking)
    "#{booking.booking_time.strftime("%A %B %e %l:%M %p")} - #{end_time(booking)}"
  end
  
  def short_time(booking)
    booking.booking_time.strftime("%b %d, %l:%M %p ")
  end
  
  def end_time(booking)
    booking.end_time.strftime("%l:%M %p")
  end
  
  def show_duration(booking)
    options = {
      1800 => "30 Minutes", 
      2700 => "45 Minutes", 
      3600 => "1 hour", 
      4500 => "1 hour and 15 minutes",
      5400 => "1 hour and 30 minutes"
    }
    options[booking.duration.to_i]
  end
  
  def show_price(booking)
    content_tag(:p, number_to_currency(booking.price) )
  end
  
  def show_venue(booking)
    content_tag(:p, booking.venue_name )
  end
  
  
end
