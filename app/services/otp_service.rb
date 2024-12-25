require "redis"

class OtpService
  def initialize
    @redis = Redis.new(host: "localhost", port: 6379, db: 0)
  end

  def generate_and_store_otp(email)
    otp = rand(100000..999999).to_s # Generate a random 6-digit OTP
    otp_hash = BCrypt::Password.create(otp) # Encrypt the OTP before saving it
    set_otp(email, otp_hash) # Save email as key and encrypted OTP as value in Redis
    otp
  end

  def validate_otp(email, otp)
    stored_otp_hash = get_otp(email) # Retrieve the encrypted OTP from Redis
    if stored_otp_hash && BCrypt::Password.new(stored_otp_hash) == otp
      delete_otp(email) # Remove OTP after successful validation
      true
    else
      false
    end
  end

  def set_otp(key, value, ttl = 300)
    @redis.set(key, value)
    @redis.expire(key, ttl)
  end

  def get_otp(key)
    @redis.get(key)
  end

  def delete_otp(key)
    @redis.del(key)
  end
end
