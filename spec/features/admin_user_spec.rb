require 'rails_helper'

RSpec.describe 'Admin User Tests On Product CRUD Operations', type: :feature do
  let!(:admin) { Admin.create!(email: 'random@example.com', password: 'random@123') }

  let!(:product) do
    Product.create!(title: 'Title', author: 'ARB Library', pub_year: '1921', category: 'Build The Collection',
                    library: 'Donald C. Harrison Health Sciences Library', description: 'Description', image: 'Image', condition_treatment: 'Condition Treatment',
                    adopt_status: 'available', adopt_amount: 11, release_year: 2020, dedication: 'Dedication', recognition: 'Recognition')
  end

  before(:each) do
    visit admin_session_path
    expect(page).to have_field('admin_email', with: nil)
    expect(page).to have_field('admin_password')
    check 'Remember me'
    uncheck 'Remember me'
    expect(page).to have_button('Log in')
    expect(page).to have_link('Sign up')
    expect(page).to have_link('Forgot your password?')
    fill_in 'Email', with: 'random@example.com'
    fill_in 'Password', with: 'random@123'
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_text('Logged in as random@example.com')
    expect(page).to have_link('Logout')
  end

  it 'Allows admin to see product details' do
    click_on 'Available Books'
    expect(page).to have_content('Title')
    expect(page).to have_content('11')
    expect(page).to have_content('ARB Library')
    expect(page).to have_content('Build The Collection')
    expect(page).to have_content('Donald C. Harrison Health Sciences Library')
    expect(page).to have_link('Read more')
    expect(page).to have_link('Edit')
    expect(page).to have_link('Destroy')
    expect(page).to have_link('New Product')
  end

  it 'Allows admin to create a New Product' do
    click_on 'Available Books'
    click_on 'New Product'
    fill_in 'product[title]', with: 'Title'
    fill_in 'product[author]', with: 'ARB Library'
    fill_in 'product[pub_year]', with: '1921'
    select 'Build the Collection', from: 'product_category'
    select 'Donald C. Harrison Health Sciences Library', from: 'product_library'
    fill_in 'product[image]', with: 'Image'
    fill_in 'product[description]', with: 'Description'
    fill_in 'product[condition_treatment]', with: 'Condition Treatment'
    select 'available', from: 'product_adopt_status'
    fill_in 'product[adopt_amount]', with: '11'
    fill_in 'product[release_year]', with: '2020'
    fill_in 'product[dedication]', with: 'Dedication'
    fill_in 'product[recognition]', with: 'Recognition'
    expect(page).to have_button('Update Product')
    expect(page).to have_link('Back')
    click_button 'Update Product'
    expect(page).to have_content('Product was successfully created.')
    expect(page).to have_content('Title')
    expect(page).to have_content('1921')
    expect(page).to have_content('11')
    expect(page).to have_content('Build the Collection')
    expect(page).to have_content('Donald C. Harrison Health Sciences Library')
    expect(page).to have_content('Description')
  end

  it 'Allows admin to edit a product' do
    click_on 'Available Books'
    click_link('Edit', match: :first)
    expect(page).to have_field('product[title]', with: 'Title')
    expect(page).to have_field('product[author]', with: 'ARB Library')
    expect(page).to have_field('product[pub_year]', with: '1921')
    expect(page).to have_select('product[category]', options: ['Build the Collection', 'Preserve for the Future'])
    expect(page).to have_select('product[library]', options: ['Archives and Rare Books Library', 'John Miller Burnam Classics Library', 'College of Engineering and Applied Science Library',
                                                              'College of Education', 'Criminal Justice and Human Services Library', 'Robert A. Deshon and Karl J. Schlachter Library for Design, Architecture, Art, and Planning',
                                                              'Geology-Mathematics-Physics Library', 'Albino Gorno Memorial Library', 'Donald C. Harrison Health Sciences Library', 'Ralph E. Oe sper Chemistry-Biology Library',
                                                              'Henry R. Winkler Center for the History of the Health Professions', 'Elliston Poetry Room'])
    expect(page).to have_field('product[image]', with: 'Image')
    expect(page).to have_field('product[description]', with: 'Description')
    expect(page).to have_field('product[condition_treatment]', with: 'Condition Treatment')
    expect(page).to have_field('product[adopt_status]', with: 'available')
    expect(page).to have_field('product[adopt_amount]', with: '11.0')
    expect(page).to have_field('product[release_year]', with: '2020')
    expect(page).to have_field('product[dedication]', with: 'Dedication')
    expect(page).to have_field('product[recognition]', with: 'Recognition')

    # fill in each field and change the values

    fill_in 'product[title]', with: 'Title2'
    fill_in 'product[author]', with: 'ARB Library'
    fill_in 'product[pub_year]', with: '1922'
    select 'Preserve for the Future', from: 'product_category'
    select 'Albino Gorno Memorial Library', from: 'product_library'
    fill_in 'product[image]', with: 'Image'
    fill_in 'product[description]', with: 'Description'
    fill_in 'product[condition_treatment]', with: 'Condition Treatment'
    select 'available', from: 'product_adopt_status'
    fill_in 'product[adopt_amount]', with: '13'
    fill_in 'product[release_year]', with: '2021'
    fill_in 'product[dedication]', with: 'Dedication'
    fill_in 'product[recognition]', with: 'Recognition'
    expect(page).to have_button('Update Product')
    expect(page).to have_link('Back')
    expect(page).to have_link('Show')
    click_button 'Update Product'

    # expect new values

    expect(page).to have_content('Product was successfully updated.')
    expect(page).to have_content('Title2')
    expect(page).to have_content('ARB Library')
    expect(page).to have_content('1922')
    expect(page).to have_content('13')
    expect(page).to have_content('Preserve for the Future')
    expect(page).to have_content('Albino Gorno Memorial Library')
    expect(page).to have_content('Description')
  end

  it 'Allows admin to see Back and Show links' do
    click_on 'Available Books'
    click_link('Edit', match: :first)
    click_link('Back')
    visit status_products_path(status: 'available')
    click_on 'Available Books'
    click_link('Edit', match: :first)
    click_link('Show')
    visit product_path(id: product.id)
  end
end
