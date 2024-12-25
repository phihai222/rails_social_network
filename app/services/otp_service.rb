require "redis"

class OtpService
  def initialize
    @redis = Redis.new(host: "localhost", port: 6379, db: 0)
  end

  def generate_and_store_otp(email)
    otp = rand(100000..999999).to_s # Generate a random 6-digit OTP
    set_otp(email, otp) # Save email as key and OTP as value in Redis
    otp
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
