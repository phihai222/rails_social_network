class RegistrationService
  attr_reader :errors

  def initialize(payload)
    @payload = payload
    @errors = []
  end

  def email_already_exists?
    User.exists?(email: @payload.email)
  end

  def register_user
    @user = User.new(@payload.to_h)
    if @user.save
      true
    else
      @errors = @user.errors.full_messages
      false
    end
  end
end
