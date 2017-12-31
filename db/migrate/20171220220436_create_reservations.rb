class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :name
      t.float :price
      t.string :date
      t.datetime :end
      t.datetime :start
      t.integer :user_id
      t.integer :venue_id

      t.timestamps
    end
  end
end
