class AddMerchantToVenues < ActiveRecord::Migration[5.1]
  def change
  	add_column :venues, :merchant_id, :string
  end
end
