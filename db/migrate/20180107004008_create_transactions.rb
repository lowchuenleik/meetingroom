class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :merchant_id
      t.integer :venue_id
      t.decimal :total

      t.timestamps
    end
  end
end
