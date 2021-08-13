FactoryBot.define do
  factory :adopter, class: 'Adopter' do
    fname { 'First Name' }
    lname { 'Last Name' }
    address { 'Address' }
    phone { '123-456-7890' }
    email { 'adopter@example.com' }
  end
end
