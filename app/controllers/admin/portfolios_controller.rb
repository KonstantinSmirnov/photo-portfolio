class Admin::PortfoliosController < AdminController
  def show
    @portfolio = Portfolio.first
  end

  def new
    @portfolio = Portfolio.new

    respond_to do |format|
      format.js { render 'render_form' }
    end
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio.save
        flash.now[:success] = 'Portfolio page has been created'
        format.js { render 'update_show'}
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'render_form' }
      end
    end
  end

  def edit
    @portfolio = Portfolio.first

    respond_to do |format|
      format.js { render 'render_form' }
    end
  end

  def update
    @portfolio = Portfolio.first

    respond_to do |format|
      if @portfolio.update_attributes(portfolio_params)
        flash.now[:success] = 'Portfolio page has been updated'
        format.js { render 'update_show' }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'render_form' }
      end
    end
  end

  def destroy
    @portfolio = Portfolio.first

    @portfolio.destroy

    flash[:success] = 'Successfully deleted'
    redirect_to admin_portfolio_path
  end

  def cancel
    @portfolio = Portfolio.first

    respond_to do |format|
      format.js { render 'update_show'}
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:title, :home_title, :description)
  end
end
