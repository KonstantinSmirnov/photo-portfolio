class Admin::ContactsController < AdminController
  def show
    @contact = Contact.first
  end

  def new
    @contact = Contact.new

    respond_to do |format|
      format.js { render 'render_form' }
    end
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        flash.now[:success] = 'Contact page has been created'
        format.js { render 'update_show' }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'render_form' }
      end
    end
  end

  def edit
    @contact = Contact.first

    respond_to do |format|
      format.js { render 'render_form' }
    end
  end

  def update
    @contact = Contact.first

    respond_to do |format|
      if @contact.update_attributes(contact_params)
        flash.now[:success] = 'Contact page has been updated'
        format.js { render 'update_show' }
      else
        flash.now[:danger] = 'Please check errors'
        format.js { render 'render_form' }
      end
    end
  end

  def destroy
    @contact = Contact.first

    @contact.destroy

    flash[:success] = 'Successfully deleted'
    redirect_to admin_contact_path
  end

  def cancel
    @contact = Contact.first

    respond_to do |format|
      format.js { render 'update_show' }
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:text, :image)
  end
end
