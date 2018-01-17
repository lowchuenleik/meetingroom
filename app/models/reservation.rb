class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :venue
	before_create :randomize_id
	
	attr_accessor :date_range

	def all_day_reservation?
	  self.start == self.start.midnight && self.end == self.end.midnight ? true : false
	end

	private

	def randomize_id
		begin
			self.id = SecureRandom.random_number(1_000_000)
		end while Reservation.where(id: self.id).exists?
	end
end
