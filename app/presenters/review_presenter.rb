class ReviewPresenter < ApplicationPresenter
  def comment
    super.present? ? super : '<i>- No comment provided -</i>'.html_safe
  end

  def time_ago
    h.time_ago_in_words(created_at)
  end
end
