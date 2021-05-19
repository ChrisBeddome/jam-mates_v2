# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def register
    @user = User.new(register_params)
    if @user.save
      render json: {user: UserSerializer.new(@user).serializable_hash}, status: :created
    else
      render json: {errors: @user.errors.full_messages},
             status: :unprocessable_entity
    end
  end

  private

  def register_params
    params.require(:user).permit(
      :email,
      :password
    )
  end
end
