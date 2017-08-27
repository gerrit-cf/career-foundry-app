class Product < ApplicationRecord
  has_many :orders

  validates :name, presence: true
  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  scope :name_like, ->(name) { where('name LIKE ?', "%#{name}%") }
end
