class Venue < ApplicationRecord
	belongs_to :user, optional:true

	validates :price, presence: true
	validates :name, presence: true

	has_attached_file :image
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
