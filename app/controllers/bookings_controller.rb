class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_bookings, only: [:index, :show, :edit]
  before_action :set_client, only: [:index, :new, :edit]
  before_action :set_venue, only: [:index, :new, :edit]
    
  def index 
    @upcoming_bookings = current_user.upcoming_bookings
  end 
  
  def show 
  end
  
  def new 
    @bookings = current_user.bookings.select { |a| a.persisted? }
    @booking = current_user.bookings.build
  end
  
  def create 
    @booking = Booking.new(booking_params.merge(user_id: current_user.id))
    if @booking.valid?
      @booking.save
      redirect_to bookings_path
    else 
      @booking.user = nil
      @bookings = current_user.bookings.select { |a| a.persisted? }
      render :new
    end
  end
  
  def edit 
  end
  
  def update 
    if @booking.update(booking_params)
      redirect_to bookings_path
    else 
      set_bookings
      render :edit
    end
  end
  
  def destroy 
    @booking.destroy 
    redirect_to bookings_path
  end
  
  private 
  
  def set_client 
    @client = current_user.clients.find_by(id: params[:client_id])
  end
  
  def set_venue
    @venue = current_user.venues.find_by(id: params[:venue_id])
  end
  
  def set_booking
    @booking = current_user.bookings.find_by(id: params[:id])
    if @booking.nil? 
      flash[:error] = "Booking not found."
      redirect_to bookings_path
    end
  end
  
  def set_bookings
    @bookings = current_user.bookings.order(booking_time: :desc)
  end
  
  def booking_params
    params.require(:booking).permit(:client_id, :price, :venue_id, venue_attributes: [:nickname], client_attributes: [:name], booking_time: [:date, :hour, :min], duration: [:hour, :min])
  end
  
end