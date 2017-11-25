class ProductPresenter < ApplicationPresenter
  def colour
    super.presence || '-'
  end

  def description
    super.presence || 'No description provided.'
  end

  def image_url
    # External ressources only for now.
    # We do not want an invalid asset to break our app.
    return '' if super.nil? || !external_url?(super)
    super
  end

  def formatted_price
    h.number_to_currency(price, unit: '€ ')
  end
end
