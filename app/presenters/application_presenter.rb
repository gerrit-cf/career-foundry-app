class ApplicationPresenter < SimpleDelegator
  def initialize(model, view)
    @view = view
    super(model)
  end

  def h
    @view
  end

  def external_url?(url)
    URI.parse(url).host.present?
  end
end
