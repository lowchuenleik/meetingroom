class Venue < ApplicationRecord
	belongs_to :user, optional:true

	validates :price, presence: true,
	validates :name, presence: true
end
