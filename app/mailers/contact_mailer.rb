class ContactMailer < ApplicationMailer
  default from: 'photo@smiplay.com'

  def new_contact_email(email)
    setting = Setting.first
    page_title = (setting.webpage_title if setting) || 'photopage'
    @email = email
    mail to: User.first.email, subject: 'Letter from ' + page_title
  end
end
