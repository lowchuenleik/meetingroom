class RenamePhotosInVenue < ActiveRecord::Migration[5.1]
  def change
  	rename_column :venues, :photos , :images
  end
end
