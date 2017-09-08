class StaticPageException < StandardError
  def initialize(message = 'The page does not exist')
    super
  end
end
