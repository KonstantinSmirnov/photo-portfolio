class SitemapController < ApplicationController
  def show
    @contact_page = Contact.first
    @portfolio_page = Portfolio.first
    @projects = Project.all
    respond_to do |format|
      format.xml
    end
  end
end
