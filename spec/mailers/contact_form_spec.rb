require 'factory_bot'
require 'rails_helper'
RSpec.describe ContactMailer, type: :mailer do
  let(:contact) { Contact.new(fname: 'test', lname: 'test', email: 'test@test.com', message: 'test') }
  it 'sends an email to Contact' do
    mail = described_class.contact_form(contact).deliver_now
    expect(mail.subject).to eq('Adopt-A-Book Contact Form Submission')
    expect(mail.to).to eq([contact.email])
    expect(mail[:from].value).to match(ENV['APP_MAIL_ADDRESS'])
  end
end
