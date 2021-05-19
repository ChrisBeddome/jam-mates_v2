# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: {user: UserSerializer.new(@user).serializable_hash}, status: :created
    else
      render json: {errors: @user.errors.full_messages},
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password
    )
  end
end
