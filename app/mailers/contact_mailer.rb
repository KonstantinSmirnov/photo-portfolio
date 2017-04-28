class ContactMailer < ApplicationMailer
  default from: "photo@smiplay.com"

  def new_contact_email(email)
    @email = email
    mail to: User.first.email, subject: "Letter from #{request.base_url}"
  end
end
