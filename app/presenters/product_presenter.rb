class ProductPresenter < ApplicationPresenter
  def description
    super.presence || 'No description provided.'
  end

  def image_url
    # External ressources only for now.
    # We do not want an invalid asset to break our app.
    return super if external_url?(super)
    ''
  end

  def truncated_description
    description.truncate(100, separator: ' ')
  end
end
