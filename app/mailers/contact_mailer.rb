class ContactMailer < ApplicationMailer
  default from: "me@MYDOMAIN.com"

  def new_contact_email(email)
    @email = email
    mail to: "k.smi@mail.ru", subject: "Success! You did it."
  end
end
