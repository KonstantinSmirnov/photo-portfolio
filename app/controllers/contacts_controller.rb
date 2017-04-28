class ContactsController < ApplicationController
  def show
    @contact = Contact.first
  end

  def create

  end
end
