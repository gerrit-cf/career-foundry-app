class AuthenticationController < ApplicationController
  before_action :verify_unauthenticated

  private

  def verify_unauthenticated
    redirect_to root_path if signed_in?
  end
end
