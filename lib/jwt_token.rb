# frozen_string_literal: true

class JwtToken
  SECRET_KEY = Rails.application.credentials.to_s

  def self.encode(payload, exp = 1.month.from_now)
    payload[:exp] = exp.to_i

    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY).first

    HashWithIndifferentAccess.new decoded
  end
end