require 'rails_helper'

RSpec.feature 'Contact Form Email', type: :feature do
  let(:contact) { FactoryBot.build(:contact) }

  it 'User fill details in contact form' do
    visit new_contact_path

    expect(page).to have_text('Contact Us')
    expect(page).to have_text('Email :')
    expect(page).to have_text('Address :')
    expect(page).to have_text('Phone :')
    expect(page).to have_selector(:link_or_button, 'Get Location')
    fill_in 'contact[fname]', with: contact.fname
    fill_in 'contact[lname]', with: contact.lname
    fill_in 'contact[email]', with: contact.email
    fill_in 'contact[phone]', with: contact.phone
    fill_in 'contact[message]', with: contact.message
    click_button 'SUBMIT'
    expect(page).to have_text('Thank You')
    expect(page).to have_text('We will get back to you soon')
    expect(page).to have_selector(:link_or_button, 'Back')
  end
end
