class Venue < ApplicationRecord
	has_many :reservations
	serialize :images , Array
	before_save :remove_blanks

	def remove_blanks
		self.images = self.images.reject { |x| x.empty? }
	end
end
