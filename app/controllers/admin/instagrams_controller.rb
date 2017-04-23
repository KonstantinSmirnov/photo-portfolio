class Admin::InstagramsController < AdminController
  def show
    @instagram = Instagram.first
  end

  def new
    @instagram = Instagram.new

    respond_to do |format|
      format.js { render 'render_form' }
    end
  end

  def create
    @instagram = Instagram.new(instagram_params)

    respond_to do |format|
      if @instagram.save
        flash.now[:success] = 'Instagram section has been created'
        format.js { render 'update_show' }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'render_form' }
      end
    end
  end

  def edit
    @instagram = Instagram.first

    respond_to do |format|
      format.js { render 'render_form' }
    end
  end

  def update
    @instagram = Instagram.first

    respond_to do |format|
      if @instagram.update_attributes(instagram_params)
        flash.now[:success] = 'Instagram section has been updated'
        format.js { render 'update_show' }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'render_form' }
      end
    end
  end

  def destroy
    @instagram = Instagram.first
    @instagram.delete

    flash[:success] = 'Successfully deleted'
    redirect_to admin_instagram_path
  end

  def cancel
    @instagram = Instagram.first

    respond_to do |format|
      format.js { render 'update_show' }
    end
  end

  private

  def instagram_params
    params.require(:instagram).permit(:text)
  end
end
