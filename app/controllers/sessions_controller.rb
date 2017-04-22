class SessionsController < ApplicationController
  def new
    @admin = User.new
  end

  def create
    if @admin = login(params[:user][:email], params[:user][:password])
      flash[:success] = 'You logged in'
      redirect_back_or_to root_path
    else
      @admin = User.new
      flash.now[:danger] = 'Login or password is invalid'
      render 'new'
    end
  end

  def destroy
    logout

    flash[:success] = 'You successfully logged out'
    redirect_to login_path
  end
end
