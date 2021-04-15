class Contact < MailForm::Base
  attribute :fname,    :validate=>true
  attribute :lname,    :validate=>true
  attribute :email,    :validate=> /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attribute :phone    
  attribute :message,  :validate=>true

def headers
  {
  :subject => "Contact Form",
  :to => "fake-admin@uc.edu",
  :from => %("#{fname} #{lname}" <#{email}>)
}
end
end
