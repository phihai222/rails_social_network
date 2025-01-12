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
      @user_info = UserService.new.save_user_info(@user.id)
      true
    else
      @errors = @user.errors.full_messages
      false
    end
  end

  def activate_user(email)
    user = User.find_by(email: email)
    if user
      user.update(active: true)
    end
  end
end
