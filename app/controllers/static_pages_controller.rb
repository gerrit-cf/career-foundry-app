class StaticPagesController < ApplicationController
  rescue_from ActionView::MissingTemplate, with: :render_404

  def index
    static_page = params[:id]
    render static_page
  end
end
