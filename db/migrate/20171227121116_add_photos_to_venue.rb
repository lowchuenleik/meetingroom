class AddPhotosToVenue < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :photos, :text
  end
end
