class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_venue, only: [:client_list, :show, :edit, :update, :destroy]
  
  def index 
    @venues = Venue.all
  end
  
  def client_list 
    @clients = @venue.clients
  end
  
  def show 
    @bookings = @venue.bookings
  end
  
  def new 
    @venue = Venue.new
  end
  
  def create 
    @venue = Venue.new(venue_params)
    if @venue.valid?
      @venue.user = current_user
      @venue.save 
      redirect_to venues_path
    else 
      render :new
    end
  end
  
  def edit 
  end 
  
  def update 
    if @venue.update(venue_params)
      redirect_to venue_path(@venue)
    else 
      render :edit
    end
  end
  
  def destroy 
    @venue.destroy 
    redirect_to venues_path
  end
  
  private 
  
  def set_venue 
    @venue = current_user.venues.find_by(id: params[:id])
    if @venue.nil?
      flash[:error] = "Venue not found."
      redirect_to venues_path
    end
  end
  
  def venue_params
    params.require(:venue).permit(:nickname, :street_address, :city, :state, :zipcode, :business_name)
  end
end