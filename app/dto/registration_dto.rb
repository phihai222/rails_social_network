class RegistrationDto
  include ActiveModel::Model
  attr_accessor :email, :password

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  STRONG_PASSWORD_REGEX = /\A
    (?=.*[A-Z])       # At lease one letter uppercase
    (?=.*[a-z])       # At lease one letter lowercase
    (?=.*\d)          # At lease one number
    (?=.*[@#$%^&*])   # At lease one special character
    .{8,}             # Minimum length 8
  \z/x

  validates :email, presence: true, length: { maximum: 100 },
            format: { with: EMAIL_REGEX, message: "is not a valid email address" }
  validates :password, presence: true, length: { minimum: 6 },
            format: { with: STRONG_PASSWORD_REGEX, message: "password must be strong" }
end
