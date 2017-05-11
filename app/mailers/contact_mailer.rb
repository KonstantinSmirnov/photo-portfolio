class ContactMailer < ApplicationMailer
  default from: "photo@smiplay.com"

  def new_contact_email(email)
    setting = Setting.first
    @email = email
    mail to: User.first.email, subject: "Letter from" + setting ? setting.webpage_title.upcase : 'photopage'
  end
end
