class Merchant < ApplicationRecord
	belongs_to :user
	has_many :venues
	has_many :transactions

	def owner
		user
	end
end
