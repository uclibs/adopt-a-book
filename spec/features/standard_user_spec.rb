require 'rails_helper'

RSpec.feature 'Standard User', type: :feature do
  let!(:product1) do
    Product.create!(title: 'Title', author: 'ARB Library', pub_year: '1921', category: 'Build The Collection',
                    library: 'Donald C. Harrison Health Sciences Library', description: 'Description', condition_treatment: 'Condition Treatment',
                    adopt_status: 'available', adopt_amount: 111, release_year: 2020)
  end

  let!(:product2) do
    Product.create!(title: 'Title2', author: 'ARB Library', pub_year: '1922', category: 'Preserve for the Future',
                    library: 'Albino Gorno Memorial Library', description: 'Description', condition_treatment: 'Condition Treatment',
                    adopt_status: 'available', adopt_amount: 112, release_year: 2020)
  end

  let!(:adopted_product) do
    Product.create!(title: 'Title Adopted', author: 'ARB Library', pub_year: '1921', category: 'Build The Collection',
                    library: 'Donald C. Harrison Health Sciences Library', description: 'Description', image: 'Image', condition_treatment: 'Condition Treatment',
                    adopt_status: 'adopted', adopt_amount: 11, release_year: 2020, dedication: 'Dedication', recognition: 'Recognition', adopter_id: '1', adopt_time: '2020-10-27 19:30:54')
  end

  let!(:adopter) { Adopter.create!(fname: 'First Name', lname: 'Last Name', address: 'Address', phone: '123-456-7890', email: 'adopter@example.com') }

  before(:each) do
    visit status_products_path(status: 'available')
  end

  describe 'Visiting Available Products' do
    it 'Searching products by Category' do
      expect(page).to have_content('Search by Category')
      select 'Build The Collection', from: 'category'
      click_button 'Search'
      expect(page).to have_content('Title')
      expect(page).to have_content('11')
      expect(page).to have_content('ARB Library')
      expect(page).to have_content('Build The Collection')
      expect(page).to have_content('Donald C. Harrison Health Sciences Library')
      expect(page).to have_link('Read more')
    end

    it 'Searching products by Library' do
      expect(page).to have_content('Search by Library')
      select 'Donald C. Harrison Health Sciences Library', from: 'library'
      click_button 'Search'
      expect(page).to have_content('Title')
      expect(page).to have_content('11')
      expect(page).to have_content('ARB Library')
      expect(page).to have_content('Build The Collection')
      expect(page).to have_content('Donald C. Harrison Health Sciences Library')
      expect(page).to have_link('Read more')
    end

    it 'Searching products by Title' do
      expect(page).to have_text('Search by Title')
      fill_in :title, with: 'Title'
      click_button 'Search'
      expect(page).to have_content('Title')
      expect(page).to have_content('11')
      expect(page).to have_content('ARB Library')
      expect(page).to have_content('Build The Collection')
      expect(page).to have_content('Donald C. Harrison Health Sciences Library')
      expect(page).to have_link('Read more')
    end

    it 'has a search and reset function features' do
      expect(page).to have_selector(:link_or_button, 'Search')
      expect(page).to have_selector(:link_or_button, 'Reset')
    end
  end

  it 'Adopting a product' do
    click_link 'Title'
    expect(page).to have_content('Title')
    expect(page).to have_content('ARB Library')
    expect(page).to have_content('1921')
    expect(page).to have_content('11')
    expect(page).to have_content('Build The Collection')
    expect(page).to have_content('Donald C. Harrison Health Sciences Library')
    expect(page).to have_content('Description')
    expect(page).to have_selector(:link_or_button, 'Add to cart')
    click_link 'Add to cart'
    expect(page).to have_selector(:link_or_button, 'View cart')
    expect(page).to have_selector(:link_or_button, 'Adopt more books')
    click_link 'View cart'
    expect(page).to have_content('Title')
    expect(page).to have_content('Recognition:')
    expect(page).to have_content('Dedication:')
    expect(page).to have_link('Remove')
    expect(page).to have_link('Clear cart')
    expect(page).to have_link('Adopt more books')
    expect(page).to have_button('Checkout')
    fill_in '1_recognition', with: 'Recognition'
    fill_in '1_dedication', with: 'Dedication'
  end

  it 'Adopting a second product and deleting it' do
    click_link 'Title'
    click_link 'Add to cart'
    click_link 'View cart'
    click_link 'Adopt more books'
    click_link 'Title2'
    expect(page).to have_content('Title2')
    expect(page).to have_content('ARB Library')
    expect(page).to have_content('1922')
    expect(page).to have_content('11')
    expect(page).to have_content('Preserve for the Future')
    expect(page).to have_content('Albino Gorno Memorial Library')
    expect(page).to have_content('Description')
    expect(page).to have_selector(:link_or_button, 'Add to cart')
    click_link 'Add to cart'
    expect(page).to have_selector(:link_or_button, 'View cart')
    expect(page).to have_selector(:link_or_button, 'Adopt more books')
    click_link 'View cart'
    expect(page).to have_content('Title2')
    expect(page).to have_content('Recognition:')
    expect(page).to have_content('Dedication:')
    expect(page).to have_link('Remove')
    expect(page).to have_link('Clear cart')
    expect(page).to have_link('Adopt more books')
    expect(page).to have_button('Checkout')
    fill_in '2_recognition', with: 'Recognition'
    fill_in '2_dedication', with: 'Dedication'
    click_link('Remove', match: :first)
    expect(page).to have_content('Title2')
    expect(page).to have_content('Recognition:')
    expect(page).to have_content('Dedication:')
    expect(page).to have_link('Remove')
    expect(page).to have_link('Clear cart')
    expect(page).to have_link('Adopt more books')
    expect(page).to have_button('Checkout')
    click_button('Checkout')
    expect(page).to have_content('Adopter information form')
    expect(page).to have_content('Title')
    fill_in 'fname', with: 'First Name'
    fill_in 'lname', with: 'Last Name'
    fill_in 'address', with: 'Address'
    fill_in 'email', with: 'adopter@example.com'
    fill_in 'phone', with: '123-456-7890'
    click_button 'Make Payment'
    expect(page).to have_content('Adopt success!')
  end
end
