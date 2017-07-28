class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def render_404
    render file: Rails.root.join('public', '404'), layout: nil, status: 404
  end
end
