require 'factory_bot'
require 'rails_helper'

RSpec.describe ContactMailer, type: :mailer do
  pending "add some examples to (or delete) #{__FILE__}"
  # it 'sends an email to Contact' do
  # ContactMailer.welcome_email(Contact.new)
  # mail = described_class.with(contact: @contact).welcome_email.deliver_now
  # expect(mail.subject).to eq('Welcome To UC Library Services')
  # expect(mail.to).to eq([@contact.email])
  # expect(mail[:from].value).to match(ENV['APP_MAIL_ADDRESS'])
  # expect(mail.body.encoded).to match('Welcome to Adopt A Book')
  # expect(mail.body.encoded).to match('Hi First Name Last Name,')
  # expect(mail.body.encoded).to match('Thanks for joining and have a great day!')
end
