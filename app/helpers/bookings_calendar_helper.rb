module BookingsCalendarHelper
  def add_weekly_calendar(bookings)
    render partial: "simple_calendar/weekly_calendar_bookings", locals: { bookings: bookings }
  end
  
  def booking_position(booking)
    "top: #{ ( ( (booking.booking_time - booking.booking_time.midnight)/3600 - 8 ) * 40 ) + 28}px;"
  end
  
  def booking_height(booking)
    "height: #{booking.duration * 40/3600}px;"
  end
  
  def at_venue(booking)
    " at #{booking.venue_name}" if booking.venue
  end
  
  def highlight_booking(booking)
    if current_page?( booking_path(booking)) || current_page?( edit_booking_path(booking) )
      " highlight"
    end
  end
  
  def booking_text(booking)
    "<span class='name'>#{booking.client_name}</span>#{at_venue(booking)}".html_safe
  end
  
  def from_to(booking)
    "#{booking.start_time.strftime("%l:%M %p")} - #{booking.end_time.strftime("%l:%M %p")}"
  end
  
  def date_of_next(day, start_date)
    date = Date.parse(day)
    delta = date >= start_date ? 0 : 7
    date + delta
  end
  
  def date_of_last(day)
    date_of_next(day) - 7.days
  end
end
