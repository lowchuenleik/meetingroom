class AddAttachmentImageToVenues < ActiveRecord::Migration[5.1]
  def self.up
    change_table :venues do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :venues, :image
  end
end
