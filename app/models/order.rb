class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :product, :user, presence: true
end
