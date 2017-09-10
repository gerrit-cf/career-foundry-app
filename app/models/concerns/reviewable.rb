module Reviewable
  extend ActiveSupport::Concern

  included do
    has_many :reviews, as: :reviewable

    def best_rated_review
      reviews.rating_desc.first
    end

    def worst_rated_review
      reviews.rating_asc.first
    end
  end
end
