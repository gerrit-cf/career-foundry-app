class ReviewSerializer < ApplicationSerializer
  include ActionView::Helpers::DateHelper

  attribute(:comment)
  attribute(:name) { object.user.to_s }
  attribute(:rating)
  attribute(:timestamp) do
    "#{time_ago_in_words(object.created_at)} ago"
  end
end
