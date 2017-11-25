module Reviewable
  extend ActiveSupport::Concern

  included do
    has_many :reviews, as: :reviewable

    def teaser_reviews
      reviews.includes(:user).created_at_desc.first(5)
    end
  end
end
