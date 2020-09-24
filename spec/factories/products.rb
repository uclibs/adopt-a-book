# frozen_string_literal: true

FactoryBot.define do
  factory :admin, class: 'Admin' do
    email { 'random@example.com' }
    password { 'random@123' }
  end
end
