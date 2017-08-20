class LandingPageController < ApplicationController
  def index
    @product = Product.first
  end
end
