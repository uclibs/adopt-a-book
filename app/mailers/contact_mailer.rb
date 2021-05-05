# ContactMailer mailer sends email to user and admin when user contact us
class ContactMailer < ActionMailer::Base
  def welcome_email(contact)
    @contact = contact
    mail({
           to: contact.email,
           from: ENV['APP_MAIL_ADDRESS'],
           subject: 'Welcome to UC Library Services'
         })
  end
end
