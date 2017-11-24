class Venue < ActiveRecord::Base
    belongs_to :user
    has_many :bookings, dependent: :destroy
    has_many :clients, through: :bookings
    
    def client_count 
        clients.count
    end
    
    def booking_count 
        bookings.count
    end
    
    def value
        bookings.collect { |a| a.price }.compact.inject(0, :+)
    end
    
    validates :nickname, presence: true
end