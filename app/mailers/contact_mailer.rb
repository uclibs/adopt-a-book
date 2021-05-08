# ContactMailer mailer sends email to user and admin when user contact us
class ContactMailer < ActionMailer::Base
  def contact_form(contact)
    @contact = contact
    mail({
           to: contact.email,
           from: ENV['APP_MAIL_ADDRESS'],
           subject: 'Adopt-A-Book Contact Form Submission'
         })
  end
end
