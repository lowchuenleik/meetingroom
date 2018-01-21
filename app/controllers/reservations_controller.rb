class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :set_venue_and_user

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = @venue.reservations

  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new

  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @merchant = @venue.merchant
    @reservation = Reservation.new(reservation_params)
    @reservation.venue_id = @venue.id
    @reservation.user_id = current_user.id

    if params[:Preview]
      redirect_to confirmation_venue_reservations_path
    end
    
    if @reservation.valid?
      token = params[:stripeToken]

      # Charge the user's card:
      charge = Stripe::Charge.create(
        :amount => 1000,
        :currency => "gbp",
        :description => "Example charge",
        :capture => false,
        :source => token,
        :destination => {
          :account => @merchant.user.uid,
        }
      )


      respond_to do |format|
        if @reservation.save! # - GOES THROUGH OKAY
          format.html { redirect_to venue_reservation_url(@venue, @reservation), notice: 'Reservation was successfully created.' }
          format.json { render :show, status: :created, location: @reservation }
        else
          format.html { render :new }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:error] = 'One or more errors'
      redirect_to confirmation_venue_reservations_path
    end
  end

  def 

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to venue_reservation_url, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to venue_reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  def save_session
    session[:reservation] = params[:reservation]
    redirect_to confirmation_path
  end

  def confirmation
    params[:reservation] = session[:reservation]
    @reservation = Reservation.new(reservation_params)
    respond_to do |format|
      format.json { render :confirmation, location: @reservation }
    end
    

    #redirect_to confirmation_venue_reservations_path

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def set_venue_and_user
      @venue = Venue.find(params[:venue_id])
      gon.venue_id = @venue.id
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:name, :commit, :reservation,:title, :price, :date, :end, :start, :user_id, :venue_id,:merchant_id,:date_range)
    end
end