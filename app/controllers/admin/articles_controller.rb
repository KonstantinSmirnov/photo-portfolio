class Admin::ArticlesController < AdminController
  before_action :get_blog

  def show
    @article = @blog.articles.find(params[:id])
  end

  def new
    @article = @blog.articles.new
  end

  def create
    @article = @blog.articles.new(article_params)

    if @article.save
      flash[:success] = 'Article has been created'
      redirect_to admin_blog_article_path(@article)
    else
      flash.now[:danger] = 'Please check errors'
      render :new
    end
  end

  def edit
    @article = @blog.articles.find(params[:id])
  end

  def update
    @article = @blog.articles.find(params[:id])
    
    if @article.update_attributes(article_params)
      flash[:success] = 'Article has been updated'
      redirect_to admin_blog_article_path(@article)
    else
      flash[:danger] = 'Please check errors'
      render 'edit'
    end
  end

  def destroy
    @article = @blog.articles.find(params[:id])
    @article.destroy

    flash[:success] = 'Article has been deleted'
    redirect_to admin_blog_path
  end

  def delete
    @article = @blog.articles.find(params[:article_id])
    @article.deleted!

    flash[:success] = 'Article has been moved to deleted'
    redirect_to :back
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :status, :publication_date)
  end

  def get_blog
    @blog = Blog.first
  end
end
