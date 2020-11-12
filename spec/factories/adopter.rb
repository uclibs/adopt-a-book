FactoryBot.define do
  factory :adopter, class: 'Adopter' do
    fname { 'First Name' }
    lname { 'Last Name' }
    address { 'Address' }
    phone { 1_234_567_890 }
    email { 'adopter@example.com' }
  end
end
