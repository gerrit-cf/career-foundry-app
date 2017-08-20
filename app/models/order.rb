class Order < ApplicationRecord
  belongs_to :product, :user

  validates :product, :user, presence: true
end
