class AddStartEndToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :start, :datetime
    add_column :bookings, :end, :datetime
   	
  end
end
