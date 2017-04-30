class PortfoliosController < ApplicationController
  def show
    @portfolio = Portfolio.first
  end
end
