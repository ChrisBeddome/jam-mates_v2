# frozen_string_literal: true

class ProfilesController < ApplicationController
  load_and_authorize_resource only: %i[create update destroy]

  def create
    if @profile.save
      render json: {profile: ProfileSerializer.new(@profile).serializable_hash}, status: :created
    else
      render json: {errors: @profile.errors.full_messages},
             status: :unprocessable_entity
    end
  end

  def show; end

  def update; end

  def destroy; end

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
