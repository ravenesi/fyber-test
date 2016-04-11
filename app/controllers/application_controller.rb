class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_page_title

  def set_page_title
    @page_title ||= params.fetch(:action).humanize
  end
end
