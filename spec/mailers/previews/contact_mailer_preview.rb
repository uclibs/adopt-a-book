# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def contact_form
    @contact = Contact
    ContactMailer.contact_form(Contact.new)
  end
end
