class LandingPageController < ApplicationController
  skip_after_action :verify_authorized

  def index
    @products = Product.first(3)
  end
end
