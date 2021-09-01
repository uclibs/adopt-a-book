FactoryBot.define do
  factory :page do
    title { 'MyString' }
    content { 'MyText' }
    sequence(:id) { |number| number }
  end
end
