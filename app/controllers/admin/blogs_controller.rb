class Admin::BlogsController < AdminController
  def show
    @blog = Blog.first
    
    @articles = @blog.articles.order('created_at desc')
  end

  def new
    @blog = Blog.new

    respond_to do |format|
      format.js { render 'render_form' }
    end
  end

  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        flash.now[:success] = 'Blog has been created'
        format.js { render 'update_show' }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'render_form' }
      end
    end
  end

  def edit
    @blog = Blog.first

    respond_to do |format|
      format.js { render 'render_form' }
    end
  end

  def update
    @blog = Blog.first

    respond_to do |format|
      if @blog.update_attributes(blog_params)
        flash.now[:success] = 'Blog page has been updated'
        format.js { render 'update_show' }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'render_form' }
      end
    end
  end

  def destroy
    @blog = Blog.first

    @blog.destroy

    flash[:success] = 'Successfully deleted'
    redirect_to admin_blog_path
  end

  def cancel
    @blog = Blog.first

    respond_to do |format|
      format.js { render 'update_show' }
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title)
  end
end
