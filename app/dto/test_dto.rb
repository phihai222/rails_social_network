class TestDto
  include ActiveModel::Model
  attr_accessor :email, :password

  validates :email, presence: true, length: { maximum: 100 }
  validates :password, presence: true, length: { minimum: 6 }
end
