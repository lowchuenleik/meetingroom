class AddStripeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stripe_temporary_token, :string
  end
end
