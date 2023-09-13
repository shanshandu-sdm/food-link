class FoodDonationsController < ApplicationController
  before_action :set_food_donation, only: %i[show edit update destroy request_donation cancel complete]
  before_action :ensure_user_is_restaurant, only: %i[new create edit update destroy]
  before_action :ensure_user_is_charity, only: %i[request_donation cancel complete]

  # GET /food_donations
  # GET /food_donations.json
  def index
    if current_user.charity?
      requested_donation = FoodDonation.where(charity_id: current_user.id, status: 1)
      @food_donations = requested_donation.empty? ? FoodDonation.all.available : requested_donation
    elsif current_user.restaurant?
      @food_donations = current_user.food_donations.all
    end
    respond_to do |format|
      format.html
      format.csv { send_data @food_donations.to_csv, filename: "donations-#{Date.today}.csv" }
    end
  end

  # GET /food_donations/1
  # GET /food_donations/1.json
  def show; end

  # GET /food_donations/new
  def new
    @food_donation = current_user.food_donations.build
  end

  # GET /food_donations/1/edit
  def edit; end

  # POST /food_donations
  # POST /food_donations.json
  def create
    @food_donation = current_user.food_donations.new(food_donation_params)
    # set donation's status to available
    @food_donation.status = 0
    respond_to do |format|
      if @food_donation.save
        format.html { redirect_to food_donations_path, notice: 'Food donation was successfully created.'}
        format.json { render :show, status: :created, location: @food_donation }
      else
        format.html { render :new }
        format.json { render json: @food_donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_donations/1
  # PATCH/PUT /food_donations/1.json
  def update
    respond_to do |format|
      if @food_donation.update(food_donation_params)
        format.html { redirect_to @food_donation, notice: 'Food donation was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_donation }
      else
        format.html { render :edit }
        format.json { render json: @food_donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_donations/1
  # DELETE /food_donations/1.json
  def destroy
    @food_donation.destroy
    respond_to do |format|
      format.html { redirect_to food_donations_url, notice: 'Food donation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def request_donation
    @food_donation.charity_id = current_user.id
    @food_donation.status = 1
    @food_donation.save
    ApplicationMailer.request_confirm(@food_donation).deliver
    redirect_to food_donations_path, notice: 'You have requested this food donation successfully.'
  end

  def cancel
    @food_donation.charity_id = nil
    @food_donation.status = 0
    @food_donation.save
    redirect_to food_donations_path, notice: 'The request was cancelled.'
  end

  def complete
    @food_donation.status = 2
    @food_donation.save
    redirect_to food_donations_path, notice: 'The food was picked up.'
  end


  protected

  def ensure_user_is_restaurant
    redirect_to(root_path) unless current_user.restaurant?
  end

  def ensure_user_is_charity
    redirect_to(root_path) unless current_user.charity?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food_donation
    @food_donation = FoodDonation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def food_donation_params
    params.fetch(:food_donation, {}).permit(:note, :available_at, :quantity)
  end
end
