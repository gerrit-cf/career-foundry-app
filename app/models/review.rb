class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  validates :user, :reviewable, presence: true
  validates :rating, numericality: { allow_nil: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  scope :rating_asc,  -> { order('rating ASC') }
  scope :rating_desc, -> { order('rating DESC') }
end
