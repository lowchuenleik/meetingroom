class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :edit, :update, :destroy, :process_charge]
  before_action :set_venue_and_user

  # GET /reservations
  # GET /reservations.json
  def index
    if @venue != nil
      @reservations = @venue.reservations
    else
      @user = current_user
      @reservations = current_user.reservations
    end

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
      flash[:alert] = "Please review the final details of your order"
      session[:reservation] = params[:reservation]
      redirect_to confirmation_venue_reservations_path

    elsif params[:block_out]
      #@reservation.color = '#E74C3C'
      respond_to do |format|
        if @reservation.save! # - GOES THROUGH OKAY
          format.html { redirect_to venue_reservation_url(@venue, @reservation), notice: 'Time slot blocked out.' }
          format.json { render :show, status: :created, location: @reservation }
        else
          format.html { render :new }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      end

    elsif @reservation.valid?
      #@reservation.color = '#2ecc71'
      token = params[:stripeToken]

      # Charge the user's card:

      charge = Stripe::Charge.create(
        :amount => @reservation.calc_amount(@venue.price),
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
          format.html { redirect_to venue_reservation_url(@venue, @reservation,fresh: 'fresh'), notice: 'Reservation was successfully created.' }
          format.json { render :show, status: :created, location: @reservation }
        else
          format.html { render :new }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:error] = @reservation.errors.full_messages.first
      redirect_to confirmation_venue_reservations_path
    end
  end

  def send_mail
    @user = current_user
    email = params[:email]
    UserMailer.welcome_email(@user, email).deliver
    flash[:notice] = "Email has been sent."
    redirect_to root_path
  end

  def time_preview
    @reservation = Reservation.new #(start:params[:start])
    @reservation.start = params[:start]
  end

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

    #respond_to do |format|
      #format.json { render :confirmation, location: @reservation }
    #end
    

    #redirect_to confirmation_venue_reservations_path

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def set_venue_and_user
      if params[:venue_id] != nil
        @venue = Venue.find(params[:venue_id])
        gon.venue_id = @venue.id
      end
      #gon.venue_business = @venue.business_hours HAVE TO IMPLEMENT
      @user = current_user
      gon.user_id = current_user.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:name,:color, :commit, :reservation,:title, :price, :date, :end, :start, :user_id, :venue_id,:merchant_id,:date_range)
    end
end
