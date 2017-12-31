class RemoveDurationFromUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :bookings, :duration, :integer
  end
end
