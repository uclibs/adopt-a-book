require 'rails_helper'
require 'spec_helper'

RSpec.describe 'welcome/index.html.erb', type: :view do
  before do
    render
  end

  it 'should have the images' do
    expect(rendered).to have_css("img[src*='slide 1']")
    expect(rendered).to have_css("img[src*='slide 2']")
    expect(rendered).to have_css("img[src*='slide 3']")
    expect(rendered).to have_css("img[src*='slide 4']")
  end

  it 'displays an welcome page' do
    expect(rendered).to have_text('The UC Libraries Adopt-A-Book program provides essential funding to support the preservation, acquisition and digitization of books, manuscripts and collections held by the region’s top-ranked research library.')
  end
end
