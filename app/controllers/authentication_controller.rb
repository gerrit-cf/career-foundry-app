class AuthenticationController < ApplicationController
  skip_after_action :verify_authorized

  before_action :verify_unauthenticated

  private

  def verify_unauthenticated
    redirect_to root_path if signed_in?
  end
end
