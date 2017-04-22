class Admin::AccountController < AdminController
  def index

  end

  def update
    if current_user.valid_password?(params[:user][:password])
      current_user.update_attributes(:email => params[:user][:email])
      flash[:success] = 'Email has been updated'
      redirect_to admin_account_path
    else
      flash.now[:danger] = 'Invalid password'
      render :index
    end
  end
end
