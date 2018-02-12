class Venue < ApplicationRecord
	has_many :reservations, dependent: :destroy
	serialize :images , Array
	before_save :remove_blanks
	accepts_nested_attributes_for :reservations
	belongs_to :merchant

	geocoded_by :street_address   # can also be an IP address
	after_validation :geocode, :if => lambda{ |obj| obj.street_address_changed? }        # auto-fetch coordinates

	def remove_blanks
		self.images = self.images.reject { |x| x.empty? }
	end

	
end
