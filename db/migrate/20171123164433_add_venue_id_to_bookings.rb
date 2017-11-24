class AddVenueIdToBookings < ActiveRecord::Migration[5.1]
  def change
    remove_column :bookings, :location_id, :integer
    add_column :bookings, :venue_id, :integer, :limit => 4
  end
end
