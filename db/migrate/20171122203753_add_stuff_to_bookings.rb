class AddStuffToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :price, :float
    add_column :bookings, :duration, :integer
    add_column :bookings, :client_id, :integer
    add_column :bookings, :booking_time, :datetime
    add_index :bookings, :user_id, name: "index_clients_on_user_id", using: :btree
  end
end
