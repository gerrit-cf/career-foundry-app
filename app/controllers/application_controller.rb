class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from NotAuthenticatedException, with: :render_404

  helper_method :signed_in?, :current_user

  def signed_in?
    session[:user_id].present?
  end

  def current_user
    @current_user ||= signed_in? ? User.find(session[:user_id]) : nil
  end

  private

  def authenticate!
    raise NotAuthenticatedException unless signed_in?
  end

  def render_404
    render file: Rails.root.join('public', '404'), layout: nil, status: 404
  end
end
