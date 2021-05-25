# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :current_user

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :unprocessable_entity
  rescue_from ActionController::UnpermittedParameters, with: :unprocessable_entity
  rescue_from CanCan::AccessDenied, with: :unauthorized

  class ActionController::Unauthorized < StandardError; end
  rescue_from ActionController::Unauthorized, with: :unauthorized

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

  protected

  def not_found
    head :not_found
  end

  def unprocessable_entity
    head :unprocessable_entity
  end

  def unauthorized
    head :unauthorized
  end
end
