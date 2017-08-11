class ProductPresenter < ApplicationPresenter
  def description
    super.presence || 'No description provided.'
  end

  def image_url_in_brackets
    "(#{image_url})" if image_url.present?
  end
end
