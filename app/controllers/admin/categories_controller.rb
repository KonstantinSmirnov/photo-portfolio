class Admin::CategoriesController < AdminController

  def new
    @portfolio = Portfolio.first
    @category = @portfolio.categories.new
    @category.id = Time.now

    respond_to do |format|
      format.js { render 'new' }
    end
  end

  def create
    @portfolio = Portfolio.first
    @category = @portfolio.categories.new(category_params)
    @category.position = Category.count

    respond_to do |format|
      if @category.save
        flash.now[:success] = 'New category has been created'
        format.js { render 'replace' }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'update_new' }
      end
    end
  end

  def edit
    @category = Category.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(category_params)
        flash.now[:success] = 'Category has been updated'
        format.js { render 'show', object: @category }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'edit' }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])

    respond_to do |format|
      @category.destroy
      flash.now[:success] = 'Category has been deleted'
      format.js { render 'destroy', object: @category }
    end
  end

  def remove_new_form
    @category = Category.new
    @category.id = params[:category_id]

    respond_to do |format|
      format.js { render 'destroy' }
    end
  end

  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.js { render 'show', object: @opinion }
    end
  end

  def cancel
    @category = Category.find(params[:category_id])

    respond_to do |format|
      format.js { render 'update' }
    end
  end

  def sort
    params[:category].each_with_index do |id, index|
      Category.find(id).update_attribute(:position, index)
    end

    render nothing: true
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

end
