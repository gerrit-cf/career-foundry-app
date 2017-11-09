class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  after_action :store_redirect_path, unless: :authentication_controller?
  after_action :verify_authorized

  rescue_from NotAuthenticatedException, with: :render_404
  rescue_from Pundit::NotAuthorizedError, with: :render_403

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

  def policy_scope(record)
    Pundit.policy_scope(current_user, record)
  end

  def authentication_controller?
    is_a?(AuthenticationController)
  end

  def store_redirect_path
    session[:redirect_path] = request.fullpath
  end

  def render_403
    render file: Rails.root.join('public', '403'), layout: nil, status: 403
  end

  def render_404
    render file: Rails.root.join('public', '404'), layout: nil, status: 404
  end

  def redis(&block)
    Redis.store(&block)
  end
end
