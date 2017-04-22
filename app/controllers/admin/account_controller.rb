class Admin::AccountController < AdminController
  def index

  end

  def update

    if current_user.valid_password?(params[:user][:password])
      case params[:target]
      when 'email'
        current_user.update_attributes(:email => params[:user][:email])
        flash[:success] = 'Email has been updated'
        redirect_to admin_account_path
      when 'password'
        current_user.password = params[:user][:new_password]
        current_user.password_confirmation = params[:user][:new_password_confirmation]
        if current_user.valid? && !params[:user][:new_password].blank?
          current_user.save!
          flash[:success] = 'Password has been updated'
          redirect_to admin_account_path
        else
          flash.now[:danger] = 'New password is invalid'
          render :index
        end
      end

    else
      flash.now[:danger] = 'Invalid password'
      render :index
    end


  end
end
