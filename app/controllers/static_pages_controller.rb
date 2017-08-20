class StaticPagesController < ApplicationController
  STATIC_PAGES = %w[about contact]

  class StaticPageError < RuntimeError; end

  rescue_from StaticPageError, with: :render_404

  before_action :set_and_verify_static_page!

  def index
    render static_page
  end

  private

  attr_reader :static_page

  def set_and_verify_static_page!
    @static_page = params[:static_page_id]
    raise StaticPageError unless static_page_valid?
  end

  def static_page_valid?
    static_page.in?(STATIC_PAGES)
  end
end
