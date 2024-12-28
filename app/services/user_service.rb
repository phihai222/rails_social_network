class UserService
  def save_user_info(user_id)
    UserInfo.create(
      user_id: user_id,
      firstName: nil,
      lastName: nil,
    ).save
  end

  def update_user_info(user_id, first_name: nil, last_name: nil, avatar_url: nil)
    user_info = UserInfo.find_by(user_id: user_id)
    if user_info
      updates = {}
      updates[:firstName] = first_name if first_name
      updates[:lastName] = last_name if last_name
      updates[:avatarUrl] = avatar_url if avatar_url
      user_info.update(updates)
    else
      raise "UserInfo not found for user_id: #{user_id}"
    end
    user_info
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
