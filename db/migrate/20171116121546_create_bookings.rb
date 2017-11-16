class CreateBookings < ActiveRecord::Migration[5.1]
  def change
  	drop_table :bookings
    create_table :bookings do |t|
      t.string :name
      t.string :date

      t.timestamps
    end
  end
end
