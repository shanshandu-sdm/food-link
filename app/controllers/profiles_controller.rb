class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[edit update]
  # GET /profiles/1/edit
  def edit; end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to edit_profile_path, notice: 'Profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = current_user.profile
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.fetch(:profile, {}).permit(:addr_line_1, :addr_line_2, :city, :state, :zip, :phone_number, :name)
  end
end
