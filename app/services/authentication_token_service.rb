# frozen_string_literal: true

class AuthenticationTokenService
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  ALGORITHM_TYPE = "HS256"
  DEFAULT_EXP = 24.hours.from_now

  def self.encode(payload, exp = DEFAULT_EXP)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, ALGORITHM_TYPE)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, algorithm: ALGORITHM_TYPE)[0]
    HashWithIndifferentAccess.new decoded
  end
end
