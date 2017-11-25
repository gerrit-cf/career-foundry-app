module Reviewable
  extend ActiveSupport::Concern

  included do
    has_many :reviews, as: :reviewable

    def average_rating
      (reviews.average(:rating) || 0).round(1)
    end

    def teaser_reviews
      reviews.includes(:user).created_at_desc.first(5)
    end
  end
end
