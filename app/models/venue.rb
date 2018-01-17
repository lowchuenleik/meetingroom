class Venue < ApplicationRecord
	has_many :reservations, dependent: :destroy
	serialize :images , Array
	before_save :remove_blanks
	accepts_nested_attributes_for :reservations
	belongs_to :merchant

	def remove_blanks
		self.images = self.images.reject { |x| x.empty? }
	end
end
