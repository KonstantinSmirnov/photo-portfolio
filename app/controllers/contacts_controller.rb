class ContactsController < ApplicationController
  def show
    @contact = Contact.first
    @email = Email.new
  end

  def create
    @email = Email.new(email_params)
    if @email.valid? && ContactMailer.new_contact_email(@email).deliver
      flash[:success] = 'Email has been sent'
      redirect_to contact_path
    else
      flash.now[:danger] = 'Please review errors'
      render :show
    end
  end

  private

  def email_params
    params.require(:email).permit(:name, :email, :topic, :message)
  end
end
