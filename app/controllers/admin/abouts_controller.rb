class Admin::AboutsController < AdminController
  def show
    @about = About.first
  end

  def new
    @about = About.new

    respond_to do |format|
      format.js { render 'render_form' }
    end
  end

  def create
    @about = About.new(about_params)

    respond_to do |format|
      if @about.save
        flash.now[:success] = 'About page has been created'
        format.js { render 'update_show'}
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'render_form' }
      end
    end
  end

  def edit
    @about = About.first

    respond_to do |format|
      format.js { render 'render_form' }
    end
  end

  def update
    @about = About.first

    respond_to do |format|
      if @about.update_attributes(about_params)
        flash.now[:success] = 'About section has been updated'
        format.js { render 'update_show' }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'render_form' }
      end
    end
  end

  def destroy
    @about = About.first
    @about.delete

    flash[:success] = 'Successfully deleted'
    redirect_to admin_about_path
  end

  def cancel
    @about = About.first

    respond_to do |format|
      format.js { render 'update_show'}
    end
  end

  private

  def about_params
    params.require(:about).permit(:title, :text, :portrait, :signature)
  end
end
