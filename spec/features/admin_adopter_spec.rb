require 'rails_helper'

RSpec.describe 'Admin User Tests On Adopter Information', type: :feature do
  let!(:admin) { Admin.create!(email: 'random@example.com', password: 'random@123') }

  let!(:adopter1) { Adopter.create!(fname: 'First Name', lname: 'Last Name', address: 'Address', phone: '123-456-7890', email: 'adopter@example.com') }

  let!(:adopter2) { Adopter.create!(fname: 'john', lname: 'doe', address: 'Address_details', phone: '789-456-7890', email: 'adopteredit@example.com') }

  let!(:adopted_product) do
    Product.create!(title: 'Title Adopted', author: 'ARB Library', pub_year: '1921', category: 'Build The Collection',
                    library: 'Donald C. Harrison Health Sciences Library', description: 'Description', image: 'Image', condition_treatment: 'Condition Treatment',
                    adopt_status: 'adopted', adopt_amount: 11, release_year: 2020, dedication: 'Dedication', recognition: 'Recognition', adopter_id: '1', adopt_time: '2020-10-27 19:30:54')
  end

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

  it 'Allows admin to login and see the adopted book details' do
    click_on 'Adopted Books'
    expect(page).to have_content('Title Adopted')
    expect(page).to have_content('11')
    expect(page).to have_content('ARB Library')
    expect(page).to have_content('Build The Collection')
    expect(page).to have_content('Donald C. Harrison Health Sciences Library')
    expect(page).to have_link('Read more')
    expect(page).to have_link('Edit')
  end

  it 'Allows admin see the adopted book and adopter details' do
    click_on 'Adopted Books'
    click_link 'Title Adopted'

    expect(page).to have_content('Title')
    expect(page).to have_content('1921')
    expect(page).to have_content('ARB Library')
    expect(page).to have_content('Description')
    expect(page).to have_content('Build The Collection')
    expect(page).to have_content('Condition Treatment')
    expect(page).to have_content('Donald C. Harrison Health Sciences Library')
    expect(page).to have_content('Adopter Details:')
    expect(page).to have_content('First Name')
    expect(page).to have_content('Last Name')
    expect(page).to have_content('Address')
    expect(page).to have_content('123-456-7890')
    expect(page).to have_content('adopter@example.com')
    expect(page).to have_content('2020-10-27 19:30:54')
    expect(page).to have_link('Edit Adopter')
  end

  it 'Allows admin to login and edit the adopter details' do
    click_on 'Adopted Books'
    click_link 'Title Adopted'
    click_link 'Edit Adopter'
    expect(page).to have_content('Editing Adopter')
    expect(page).to have_field('adopter[fname]', with: 'First Name')
    expect(page).to have_field('adopter[lname]', with: 'Last Name')
    expect(page).to have_field('adopter[address]', with: 'Address')
    expect(page).to have_field('adopter[phone]', with: '123-456-7890')
    expect(page).to have_field('adopter[email]', with: 'adopter@example.com')

    # fill in new values

    fill_in 'adopter[fname]', with: 'john'
    fill_in 'adopter[lname]', with: 'doe'
    fill_in 'adopter[address]', with: 'Address'
    fill_in 'adopter[phone]', with: '789-456-7890'
    fill_in 'adopter[email]', with: 'adopteredit@example.com'
    expect(page).to have_button('Update Adopter')
    expect(page).to have_link('Cancel')
    click_button 'Update Adopter'
    expect(page).to have_content('Adopter Details Was Successfully Updated')
    expect(page).to have_content('Title')
    expect(page).to have_content('1921')
    expect(page).to have_content('ARB Library')
    expect(page).to have_content('Description')
    expect(page).to have_content('Build The Collection')
    expect(page).to have_content('Donald C. Harrison Health Sciences Library')
    expect(page).to have_content('Condition Treatment')
    expect(page).to have_content('Adopter Details:')
    expect(page).to have_content('john')
    expect(page).to have_content('doe')
    expect(page).to have_content('Address')
    expect(page).to have_content('789-456-7890')
    expect(page).to have_content('adopteredit@example.com')
    expect(page).to have_content('2020-10-27 19:30:54')
  end
end
