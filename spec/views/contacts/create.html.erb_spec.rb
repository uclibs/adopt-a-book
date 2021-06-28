require 'rails_helper'
RSpec.describe('/contacts/create', type: :view) do
  it 'has a thank you message' do
    render
    expect(rendered).to have_text('Thank You!')
  end
  it 'tells the user we will respond' do
    render
    expect(rendered).to have_text('We will get back to you soon')
  end
end
