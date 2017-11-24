class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
                 :recoverable, :rememberable, :trackable, :validatable
         
    has_many :clients
    has_many :bookings 
    has_many :venues
    
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user| 
            user.email = auth.info.email 
            user.password = Devise.friendly_token[0,20]
        end
    end
    
    def upcoming_bookings
        bookings.order(booking_time: :desc).select{ |a| a.booking_time > (DateTime.now) }
    end
    
end