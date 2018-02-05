class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]
  before_action :set_merchant, only: [:show, :edit, :update, :destroy, :new, :create]

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all
    if user_signed_in?
      @merchant = current_user.merchants.first #HACKY
    end
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
  end

  # GET /venues/new
  def new
    @venue = @merchant.venues.build
  end

  # GET /venues/1/edit
  def edit
    if @merchant == nil
      redirect_to merchant_venue_edit_url
    end
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = @merchant.venues.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to merchant_venue_url(@merchant,@venue), notice: 'Venue was successfully created.' }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to merchant_venue_path, notice: 'Venue was successfully updated.' }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to merchant_path(@merchant), notice: 'Venue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    def set_merchant
      if params[:merchant_id]
        @merchant =  Merchant.find(params[:merchant_id])
      else
        @merchant = @venue.merchant
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:name, :price, :byline, :host, :capacity, :street_address, :postcode,:merchant_id, images: [])
    end
end
