class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  validates :user, :reviewable, presence: true
  validates :rating, numericality: { allow_nil: true, only_integer: true }, inclusion: 1..5

  scope :rating_asc,  -> { order('rating ASC') }
  scope :rating_desc, -> { order('rating DESC') }
end
