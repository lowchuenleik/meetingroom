class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string :uid
      t.string :provider
      t.string :access_code
      t.string :publishable_key
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
