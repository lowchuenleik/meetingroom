class CreateVenues < ActiveRecord::Migration[5.1]
  def change
    drop_table :venues, force: :cascade
    create_table :venues do |t|
      t.string :name
      t.integer :price
      t.string :byline
      t.string :host
      t.integer :capacity
      t.string :street_address
      t.string :postcode

      t.timestamps
    end
  end
end
