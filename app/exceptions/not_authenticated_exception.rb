class NotAuthenticatedException < StandardError
  def initialize(message = 'You are not authenticated')
    super
  end
end
