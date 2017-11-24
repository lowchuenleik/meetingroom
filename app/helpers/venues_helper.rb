module VenuesHelper
  def show_street_address(venue)
    venue.street_address if venue.street_address
  end
  
  def city_state_zip(venue)
    "#{venue.city}, #{venue.state} #{venue.zipcode}" if venue.city && venue.state && venue.zipcode
  end
  
  def show_nickname(venue)
    if current_page?(venue_path(venue))
      venue.nickname
    else 
      link_to venue.nickname, venue_path(venue)
    end
  end
  
  def show_address(venue)
    
    render partial: "venues/address", locals: { venue: venue }
  end
  
  def edit_delete_links(venue)
    output = [
      link_to("Edit", edit_venue_path(venue), class: "btn btn-secondary"),
      link_to("Delete", venue, method: :delete, class: "btn btn-danger", data: { confirm: "Are you sure you really want to delete this venue" })
    ]
    safe_join(output)
  end
  
  def booking_count(venue)
    link_to pluralize(venue.booking_count, 'booking'), venue_path(venue)
  end
  
  def venue_value(venue)
    number_to_currency(venue.value) if venue.value != 0
  end
  
  def client_count(venue)
    link_to pluralize(venue.client_count, 'client'), client_path(venue)
  end
  
  
end
