# frozen_string_literal: true

FactoryBot.define do
  factory :product, class: 'Product' do
    title { 'Title' }
    author { 'Author' }
    pub_year { 'Pub Year' }
    category { 'Category' }
    image { 'Image' }
    library { 'Library' }
    description { 'Description' }
    condition_treatment { 'Condition Treatment' }
    adopt_status { 2 }
    adopt_amount { '1500.39' }
    release_year { 2020 }
    dedication { 'Dedication' }
    recognition { 'Recognition' }
  end
end
