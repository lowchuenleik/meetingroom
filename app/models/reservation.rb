class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :venue
	
	attr_accessor :date_range

	def all_day_reservation?
	  self.start == self.start.midnight && self.end == self.end.midnight ? true : false
	end
end
