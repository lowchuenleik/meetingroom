class AddBylineAndCapacityToVenues < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :byline, :string
    add_column :venues, :capacity, :integer
  end
end
