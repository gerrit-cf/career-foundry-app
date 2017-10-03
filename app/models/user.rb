class User < ApplicationRecord
  has_secure_password

  has_many :orders
  has_many :reviews

  validates :email, presence: true, uniqueness: true

  def admin?
    role == 'admin'
  end

  def to_s
    [first_name, last_name].join(' ')
  end
end
