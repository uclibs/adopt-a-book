require 'rails_helper'

RSpec.feature 'pages form', type: :feature do
  let(:test_page) { FactoryBot.create(:page) }
  it 'Visit the event/donor page' do
    visit page_path(test_page)
    expect(page).to have_text('MyString')
    expect(page).to have_text('MyText')
  end
end
