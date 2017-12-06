class Booking < ActiveRecord::Base
    belongs_to :venue
    belongs_to :user
    belongs_to :client
    
    accepts_nested_attributes_for :client
    accepts_nested_attributes_for :venue
    
    def start_time
        self.booking_time
    end
    
    def end_time
        booking_time + duration.seconds
    end
    
    def client_name 
        client.name
    end
    
    def venue_name 
        venue.nickname if venue
    end
    
    ## Form Parsing methods
    
    def client_attributes=(atts)
        if atts[:name] != ""
            self.client = self.user.clients.find_or_create_by(atts)     
        end
    end
    
    def venue_attributes=(atts)
        if atts[:nickname] != ""
            venue = self.user.venues.find_or_create_by(atts)    
            self.venue = venue
        end
    end
    
    def booking_time=(time)
        if time.is_a?(Hash)
            self[:booking_time] = parse_datetime(time) 
        else
            self[:booking_time] = time
        end
    end
    
    def parse_date(string)
        array = string.split("/")
        first_item = array.pop
        array.unshift(first_item).join("-")
    end
    
    def parse_datetime(hash)
        if hash["date"].match(/\d{2}\/\d{2}\/\d{4}/)
            Time.zone.parse("#{parse_date(hash["date"])} #{hash["hour"]}:#{hash["min"]}")
        end
    end
    
    def duration=(duration) 
        if duration.is_a?(Hash)
            self[:duration] = parse_duration(duration)
        else 
            self[:duration] = duration
        end
    end
    
    def parse_duration(hash)
        hash["hour"].to_i + hash["min"].to_i
    end
    
    ## Validations 
    
    validates :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :booking_time, presence: { message: "must be a valid date" }
    validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true 
    validates :client_id, presence: true
    
    validate :time_still_valid
    
    def time_still_valid
        BookingTimeValidator.new(self).validate
    end
    
    include ActiveModel::Validations 
    
    class BookingTimeValidator 
        def initialize(booking)
            @booking = booking 
            @user = booking.user
        end
        
        def validate 
            if @booking.booking_time
                # selects the user's bookings from yesterday, today and tomorrow
                bookings = @user.bookings.select { |a| a.booking_time.midnight == @booking.booking_time.midnight || a.booking_time.midnight == @booking.booking_time - 1.day || a.booking_time.midnight == @booking.booking_time + 1.day }
                # makes sure that current bookings don't overlap
                # first checks if an existing booking is still
                # in progress when the new booking is set to start
                # next checks if the new booking would still be in 
                # progress when an existing booking is set to start
                bookings.each do |booking|
                    if @booking != booking 
                        if booking.booking_time <= @booking.booking_time && @booking.booking_time <= booking.end_time || @booking.booking_time <= booking.booking_time && booking.booking_time <= @booking.end_time
                            @booking.errors.add(:booking_time, "is not available.")
                        end
                    end
                end
            end
            
        end
        
    end
    
    validate do |booking| 
        BookingTimeValidator.new(booking).validate
    end
    
end