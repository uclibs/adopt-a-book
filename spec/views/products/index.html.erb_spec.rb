require('rails_helper')

RSpec.describe('products/index', type: :view) do
  include Pagy::Backend

  before(:each) do
    # @products = FactoryBot.create_list(:product, 2)
    @pagy, @products = pagy_array(FactoryBot.create_list(:product, 2), items: ENV['ITEMS_PER_PAGE'])
    @adopt_status = 'available'
  end

  context 'for available books with status is available' do
    before do
      @pagy, @products = pagy(Product.send('available'), items: ENV['ITEMS_PER_PAGE'])
      @adopt_status = 'available'
    end
    it 'renders a list of products' do
      render
      assert_select 'tr>td', text: 'Title'.to_s, count: 2
      assert_select 'tr>td', text: 'Author: Author'.to_s, count: 2
      assert_select 'tr>td', text: 'Category: Category'.to_s, count: 2
      assert_select 'tr>td', text: 'Library: Library'.to_s, count: 2
      assert_select 'tr>td', text: 'Adoption amount: ' + number_to_currency('1500.39', strip_insignificant_zeros: true), count: 2
    end
  end

  context 'for adopted books with status is adopted' do
    before do
      @pagy, @products = pagy(Product.send('adopted'), items: ENV['ITEMS_PER_PAGE'])
      @adopt_status = 'adopted'
    end
    it 'renders a list of products' do
      render
      assert_select 'tr>td', text: 'Title: Title'.to_s, count: 0, href: @product
      assert_select 'tr>td', text: 'Author: Author'.to_s, count: 0
      assert_select 'tr>td', text: 'Category: Category'.to_s, count: 0
      assert_select 'tr>td', text: 'Library: Library'.to_s, count: 0
    end
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

  it 'displays a pagination widget' do
    render
    expect(rendered).to have_text('Prev1Next')
  end
end
