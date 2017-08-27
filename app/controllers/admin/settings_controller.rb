class Admin::SettingsController < AdminController
  def new
    @settings = Setting.new
  end

  def create
    @settings = Setting.new(settings_params)

    if @settings.save
      flash[:success] = 'Settings were created'
      redirect_to edit_admin_setting_path
    else
      flash.now[:danger] = 'Please check errors'
      render 'new'
    end
  end

  def edit
    @settings = Setting.first
  end

  def update
    @settings = Setting.first

    if @settings.update_attributes(settings_params)
      flash[:success] = 'Settings were updated'
      redirect_to edit_admin_setting_path
    else
      flash.now[:danger] = 'Please check errors'
      render 'edit'
    end
  end

  def destroy
    @settings = Setting.first
    @settings.destroy

    flash[:success] = 'Successfully deleted'
    redirect_to edit_admin_setting_path
  end

  private

  def settings_params
    params.require(:setting).permit(:webpage_title,
                                    :seo_description,
                                    :seo_keywords,
                                    :seo_text,
                                    :contact_phone,
                                    :contact_email,
                                    :facebook,
                                    :analytics)
  end
end
