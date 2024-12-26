class JwtService
  SECRET_KEY = Rails.application.secret_key_base # Get secret default from application

  # Generate token with payload and expiration time
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  # Decode token and validate expiration time
  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(body)
  rescue JWT::DecodeError => e
    raise StandardError.new "Invalid or expired token: #{e.message}"
  end
end
