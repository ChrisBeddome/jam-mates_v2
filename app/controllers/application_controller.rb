# frozen_string_literal: true

class ApplicationController < ActionController::API
  def current_user
    @current_user ||= user_from_token
  end

  private

  def user_from_token
    token = extract_bearer_token
    return nil unless token

    decoded = AuthenticationTokenService.decode(token)
    User.find(decoded[:user_id])
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    nil
  end

  def extract_bearer_token
    pattern = /^Bearer /
    header = request.headers["Authorization"]
    header.gsub(pattern, "") if header&.match(pattern)
  end
end
