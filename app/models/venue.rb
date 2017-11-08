class Venue < ApplicationRecord
	belongs_to :user, optional:true
end
