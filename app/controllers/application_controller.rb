class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :initialize_app

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def initialize_app
    @contact = Contact.first
    @portfolio = Portfolio.first
    @instagram = Instagram.first
    @setting = Setting.first
  end

  def render_404
    render template: 'errors/error_404', status: 404
  end
end
