require('rails_helper')

RSpec.describe('products/index', type: :view) do
  include Pagy::Backend

  before(:each) do
    allow(view).to receive(:params).and_return('status' => 'adopted')
    # @products = FactoryBot.create_list(:product, 2)
    @pagy, @products = pagy_array(FactoryBot.create_list(:product, 2), items: ENV['ITEMS_PER_PAGE'])
    @adopt_status = 'available'
  end

  context 'for available books' do
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

  context 'for adopted books' do
    before do
      FactoryBot.create_list(:adopted_product, 2)
      @pagy, @products = pagy(Product.send('adopted'), items: ENV['ITEMS_PER_PAGE'])
      @adopt_status = 'adopted'
    end
    it 'renders a list of products' do
      render
      assert_select 'tr>td', text: 'Title'.to_s, count: 2, href: @product
      assert_select 'tr>td', text: 'Author: Author'.to_s, count: 2
      assert_select 'tr>td', text: 'Category: Category'.to_s, count: 2
      assert_select 'tr>td', text: 'Library: Library'.to_s, count: 2
    end
  end

  context 'for pending books' do
    before do
      FactoryBot.create_list(:pending_product, 2)
      @pagy, @products = pagy(Product.send('pending'), items: ENV['ITEMS_PER_PAGE'])
      @adopt_status = 'pending'
    end
    it 'renders a list of products' do
      render
      assert_select 'tr>td', text: 'Title'.to_s, count: 2, href: @product
      assert_select 'tr>td', text: 'Author: Author'.to_s, count: 2
      assert_select 'tr>td', text: 'Category: Category'.to_s, count: 2
      assert_select 'tr>td', text: 'Library: Library'.to_s, count: 2
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

  describe 'when admin is logged in' do
    context 'product is available' do
      before(:each) do
        admin = FactoryBot.create(:admin)
        sign_in_admin(admin)
      end

      def sign_in_admin(admin)
        sign_in admin
      end

      it 'should allow admin to see edit link' do
        render
        expect(rendered).to have_link('Edit', count: 2)
      end

      it 'should allow admin to see new product and destroy links' do
        render
        expect(rendered).to have_link('Destroy', count: 2)
        expect(rendered).to have_link('New Product', href: new_product_path, count: 1)
      end
    end

    context 'product is adopted' do
      before do
        FactoryBot.create_list(:adopted_product, 2)
        @pagy, @products = pagy(Product.send('adopted'), items: ENV['ITEMS_PER_PAGE'])
        @adopt_status = 'adopted'
      end

      it 'should not allow admin to see new product and destroy links when the product is adopted' do
        render
        expect(rendered).to have_no_link('Destroy')
        expect(rendered).to have_no_link('New Product')
      end
    end

    context 'product is pending' do
      before do
        FactoryBot.create_list(:pending_product, 2)
        @pagy, @products = pagy(Product.send('pending'), items: ENV['ITEMS_PER_PAGE'])
        @adopt_status = 'pending'
      end

      it 'should not allow admin to see new product and destroy links when the product is adopted' do
        render
        expect(rendered).to have_no_link('Destroy')
        expect(rendered).to have_no_link('New Product')
      end
    end
  end

  it 'displays a pagination widget' do
    render
    expect(rendered).to have_text('1Next')
  end
end
