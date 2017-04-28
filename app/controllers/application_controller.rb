class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :login_header_items

  def login_header_items
    @contact = Contact.first
  end
end
