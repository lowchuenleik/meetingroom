class AddInstructionsToVenues < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :instructions, :string
  end
end
