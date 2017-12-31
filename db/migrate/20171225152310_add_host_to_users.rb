class AddHostToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :host, :boolean
  	add_column :reservations, :color, :string
  end
end
