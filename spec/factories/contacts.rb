require 'factory_bot'

FactoryBot.define do
  factory :contact do
    fname { 'First Name' }
    lname { 'Last Name' }
    email { 'contact@example.com' }
    phone { 1_234_567_890 }
    message { 'hello' }
  end
end
