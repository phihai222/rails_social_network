class RegistrationDto
  include ActiveModel::Model
  attr_accessor :email, :password

  validates :email, presence: true, length: { maximum: 100 } #TODO validate email
  validates :password, presence: true, length: { minimum: 6 } # TODO make a regex here
end
