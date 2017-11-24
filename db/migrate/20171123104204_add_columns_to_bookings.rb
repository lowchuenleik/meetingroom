class AddColumnsToBookings < ActiveRecord::Migration[5.1]
  def change
  	add_column :bookings, :location_id, :integer
  	add_column :venues, :user_id, :integer, :limit => 4
  	add_column :venues, :business_name, :string, :limit => 255
  	add_column :venues, :zipcode, :string, :limit => 255
  	add_column :venues, :state, :string, :limit => 255
  	add_column :venues, :street_address, :string, :limit => 255
  	add_column :venues, :city, :string, :limit => 255
  	add_column :venues, :nickname, :string, :limit => 255

  	add_foreign_key :bookings, :clients
  	add_foreign_key :bookings, :venues
  	add_foreign_key :bookings, :users
  end
end
