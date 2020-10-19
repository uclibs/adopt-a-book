require('rails_helper')

RSpec.describe('products/index', type: :view) do
  before(:each) do
    @products = FactoryBot.create_list(:product, 2)
  end

  it 'renders a list of products' do
    render
    assert_select 'tr>td', text: 'Title: Title'.to_s, count: 2
    assert_select 'tr>td', text: 'Author: Author'.to_s, count: 2
    assert_select 'tr>td', text: 'Category: Category'.to_s, count: 2
    assert_select 'tr>td', text: 'Library: Library'.to_s, count: 2
    assert_select 'tr>td', text: 'Adoption amount: ' + number_to_currency('1500.39', strip_insignificant_zeros: true), count: 2
  end

  context 'when admin is not logged in' do
    it 'should not allow admin/adopters to see edit, delete and new product links' do
      render
      expect(rendered).to have_no_link('Edit')
      expect(rendered).to have_no_link('Destroy')
      expect(rendered).to have_no_link('New Product', href: new_product_path)
    end

    it 'should not display logout link' do
      render
      expect(rendered).to have_no_link('Logout')
    end

    it 'should not display login information' do
      render
      expect(rendered).to have_no_text('Logged in as random@example.com')
    end
  end

  context 'when admin is logged in' do
    before(:each) do
      admin = FactoryBot.create(:admin)
      sign_in_admin(admin)
    end

    def sign_in_admin(admin)
      sign_in admin
    end

    it 'should allow admin to see edit, delete and new product links' do
      render
      expect(rendered).to have_link('Edit', count: 2)
      expect(rendered).to have_link('Destroy', count: 2)
      expect(rendered).to have_link('New Product', href: new_product_path, count: 1)
    end

    it 'should display logout link' do
      render
      expect(rendered).to have_link('Logout', href: destroy_admin_session_path)
    end

    it 'should display login information' do
      render
      expect(rendered).to have_text('Logged in as random@example.com')
    end
  end
end
