require 'rails_helper'

RSpec.describe AdoptionMailer, type: :mailer do
  it 'sends an email to adopter' do
    @adopter = FactoryBot.create(:adopter)
    mail = described_class.with(adopter: @adopter).thank_you_email.deliver_now
    expect(mail.subject).to eq('UC Libraries Adopt-A-Book confirmation')
    expect(mail.to).to eq([@adopter.email])
    expect(mail[:from].value).to match(ENV['ADMIN_MAIL_ADDRESS'])
    expect(mail.body.encoded).to match('Adopt-a-book program by University of Cincinnati Libraries')
    expect(mail.body.encoded).to match('Hi First Name Last Name,')
    expect(mail.body.encoded).to match('Thank you.')
  end

  it 'sends an email to admin' do
    FactoryBot.create_list(:product, 2)
    @adopter = FactoryBot.create(:adopter)
    mail = described_class.with(product_ids: %w[1 2], adopter: @adopter).adoption_notification_email.deliver_now
    expect(mail.subject).to eq('Adopted Book PRE-ORDER')
    expect(mail[:to].value).to eq(ENV['ADMIN_MAIL_ADDRESS'])
    expect(mail[:from].value).to eq(ENV['APP_MAIL_ADDRESS'])
    expect(mail.body.encoded).to match('Adopt-a-book program by University of Cincinnati Libraries')
    expect(mail.body.encoded).to match('We received an order through \'Adopt-a-book\' program.')
    expect(mail.body.encoded).to match('Number of books: 2')
    expect(mail.body.encoded).to match('[1,2]')
    expect(mail.body.encoded).to match('["Title","Title"]')
    expect(mail.body.encoded).to match('Name: First Name Last Name')
    expect(mail.body.encoded).to match('Address: Address')
    expect(mail.body.encoded).to match('Phone: 1234567890')
    expect(mail.body.encoded).to match('Email: adopter@example.com')
    expect(mail.body.encoded).to match('Please track the adoption process and change the adopt_status to \'1\' once the payment is done.')
  end
end
