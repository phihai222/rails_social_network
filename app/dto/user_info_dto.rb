class UserInfoDto
  include ActiveModel::Model
  attr_accessor :firstName, :lastName, :avatarUrl

  validates :firstName, length: { maximum: 100 }
  validates :lastName, length: { maximum: 100 }

  def to_h
    {
      first_name: firstName,
      last_name: lastName,
      avatar_url: avatarUrl
    }
  end

  def self.from_model(user)
    new(
      firstName: user.firstName,
      lastName: user.lastName,
      avatarUrl: user.avatarUrl
    )
  end
end
