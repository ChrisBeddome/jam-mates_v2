# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user, only: %i[create update destroy]

  def create
    profile = Profile.new(profile_params)
    #authorize
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def profile_params
    params.require(:profile).permit(
      :user_id,
      :first_name,
      :last_name,
      :birth_date,
      :bio,
      :latitude,
      :longitude
    )
  end
end