class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  validates :rating, numericality: { only_integer: true }, inclusion: 1..5

  scope :rating_asc,  -> { order('rating ASC') }
  scope :rating_desc, -> { order('rating DESC') }

  self.per_page = 5
end
