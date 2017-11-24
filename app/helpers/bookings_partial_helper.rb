module BookingsPartialHelper
  def booking_heading(booking)
    if current_page?(booking_path(booking))
      content_tag(:h3, link_to(show_client_name(booking), client_path(booking.client) ) )
    else
      render partial: "bookings/booking_short", locals: { booking: booking }
    end
  end
  
  def show_client_name(booking)
    if current_page?(bookings_path)
      link_to booking.client_name, booking_path(booking)
    else 
      booking.client_name
    end
  end
  
  def booking_details(booking)
    if current_page?(booking_path(booking))
      render partial: "bookings/booking_details", locals: { booking: booking }
    end
  end
  
  def booking_edit_delete_links(booking)
    links = [link_to("Edit", edit_booking_path(booking) ),
    link_to("Delete", booking, method: :delete, data: { confirm: "Are you sure you want to delete this booking?" } )]
    safe_join(links, ", ")
  end
  
end
