module ClientsHelper
  def client_email(client)
    client.email if client.email != ""
  end
  
  def client_name(client)
    if current_page?(clients_path)
      link_to client.name, client_path(client)
    else
      client.name
    end
  end
  
  def client_value(client)
    number_to_currency(client.value) if client.value != 0
  end
  
  def booking_count(client)
    link_to "Total Bookings: #{client.booking_count}", client_path(client)
  end
  
end
