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
    adopt_status { 'available' }
    adopt_amount { '1500.39' }
    release_year { 2020 }
  end

  factory :adopted_product, class: 'Product' do
    title { 'Title' }
    author { 'Author' }
    pub_year { 'Pub Year' }
    category { 'Category' }
    image { 'Image' }
    library { 'Library' }
    description { 'Description' }
    condition_treatment { 'Condition Treatment' }
    adopt_status { 'adopted' }
    adopt_amount { '1500.39' }
    release_year { 2020 }
    dedication { 'Dedication' }
    recognition { 'Recognition' }
    adopter_id { 1 }
    adopt_time { '2020-10-27 19:30:54' }
  end

  factory :pending_product, class: 'Product' do
    title { 'Title' }
    author { 'Author' }
    pub_year { 'Pub Year' }
    category { 'Category' }
    image { 'Image' }
    library { 'Library' }
    description { 'Description' }
    condition_treatment { 'Condition Treatment' }
    adopt_status { 'pending' }
    adopt_amount { '1500.39' }
    release_year { 2020 }
  end
end
