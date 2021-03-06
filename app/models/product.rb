class Product < ApplicationRecord
  include Reviewable

  has_many :orders

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  scope :name_like, ->(name) { where('name ilike ?', "%#{name}%") }

  def price_in_cents
    (price * 100).floor
  end

  def to_s
    name
  end
end
