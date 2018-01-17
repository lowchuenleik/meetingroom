class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
                 :recoverable, :rememberable, :trackable, :validatable,
                 :omniauthable, :omniauth_providers => [:stripe_connect]
         
    has_many :clients
    has_many :bookings 
    has_many :merchants, dependent: :destroy
    has_many :transactions
    
    accepts_nested_attributes_for :merchants


    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user| 
            user.email = auth.info.email 
            user.password = Devise.friendly_token[0,20]
        end
    end
    
    def is_seller?
        merchants.any?
    end

    def upcoming_bookings
        bookings.order(booking_time: :desc).select{ |a| a.booking_time > (DateTime.now) }
    end
    
    def can_receive_payments?
        uid? &&  provider? && access_code? && publishable_key?
    end

    def can_make_payments?
        self.stripe_customer_id.present?
    end
    
end