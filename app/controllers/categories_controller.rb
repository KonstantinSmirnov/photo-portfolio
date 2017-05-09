class CategoriesController < ApplicationController
  def index
    @portfolio = Portfolio.first
    @projects = @portfolio.projects
  end

  def show
    @portfolio = Portfolio.first
    @projects = @portfolio.projects.where(category: params[:id])
  end
end
