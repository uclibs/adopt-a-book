# contact model describes model attributes of contacts
class Contact < MailForm::Base
  attribute :fname,    validate: true
  attribute :lname,    validate: true
  attribute :email,    validate: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attribute :phone,    validate: /\d[0-9]\)*\z/, allow_blank: true
  attribute :message, validate: true

  def headers
    {
      subject: 'Contact Form',
      to: ENV['APP_MAIL_ADDRESS'],
      from: %("#{fname} #{lname}" <#{email}>)
    }
  end
end
