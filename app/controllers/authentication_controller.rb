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

  def login
    @user = User.find_by(email: login_params[:email])&.authenticate(login_params[:password])

    if @user
      render json: {
        access_token: AuthenticationTokenService.encode(user_id: @user.id),
        user: UserSerializer.new(@user).serializable_hash,
        status: :ok
      }
    else
      head :unauthorized
    end
  end

  private

  def register_params
    params.require(:user).permit(
      :email,
      :password
    )
  end

  def login_params
    params.require(:credentials).permit(
      :email,
      :password
    )
  end
end
