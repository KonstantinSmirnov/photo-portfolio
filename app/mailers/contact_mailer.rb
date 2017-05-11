class ContactMailer < ApplicationMailer
  default from: "photo@smiplay.com"

  def new_contact_email(email)
    title = Setting.first.webpage_title
    page_title = title ? title : 'photopage'
    @email = email
    mail to: User.first.email, subject: "Letter from " + page_title
  end
end
