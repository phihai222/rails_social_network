class UserService
  def save_user_info(user_id)
    UserInfo.create(
      user_id: user_id,
      firstName: nil,
      lastName: nil,
    ).save
  end

  def update_user_info(user_id, first_name: nil, last_name: nil)
    user_info = UserInfo.find_by(user_id: user_id)
    if user_info
      user_info.update(firstName: first_name, lastName: last_name)
    else
      raise "UserInfo not found for user_id: #{user_id}"
    end
  end

  def get_user_info(user_id)
    user_info = UserInfo.find_by(user_id: user_id)
    if user_info
      user_info
    else
      raise "UserInfo not found for user_id: #{user_id}"
    end
  end
end
