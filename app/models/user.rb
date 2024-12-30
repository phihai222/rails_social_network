class User < ApplicationRecord
  has_many :posts
  has_secure_password

  validates :password, presence: true, length: { minimum: 8 }, if: :password_required?

  private

  def password_required?
    new_record? || password.present?
  end
end
