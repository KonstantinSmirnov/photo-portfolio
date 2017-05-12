class CategoriesController < ApplicationController
  def index
    @portfolio = Portfolio.first
    @projects = @portfolio.projects.order('date DESC')
    @categories = @portfolio.categories_with_projects.sort_by{ |e| e[:position] }
  end

  def show
    @portfolio = Portfolio.first
    @projects = @portfolio.projects.where(category: params[:id]).order('date DESC')
    @categories = @portfolio.categories_with_projects.sort_by{ |e| e[:position] }
  end
end
