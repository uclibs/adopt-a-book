require('rails_helper')

RSpec.describe('cart/index', type: :view) do
  before(:each) do
    @products = FactoryBot.create_list(:product, 2)
  end

  describe 'when cart is empty' do
    before do
      session[:cart] = {}
      @cart = []
    end
    it 'renders attributes in <p>' do
      render
      expect(rendered).to(match(/The cart is empty./))
      expect(rendered).to have_selector('img', count: 1)
      expect(rendered).to have_link('Adopt books')
    end
  end

  describe 'when cart has products' do
    context 'and the product has no dedication or recognition, ' do
      before do
        session[:cart] = { '1' => {}, '2' => {} }
        @cart = Product.find(session[:cart].keys)
      end
      it 'renders all products in the cart' do
        render
        expect(rendered).to have_content('$1,500.39', count: 2)
        expect(rendered).to have_content('Total price: $3,000.78')
        expect(rendered).to have_selector('img', count: 4)
        assert_select 'div>a', text: 'Title'.to_s, count: 2
        assert_select 'div>label', text: 'Dedication:'.to_s, count: 2
        assert_select 'div>label', text: 'Recognition:'.to_s, count: 2
        assert_select 'div>input', count: 5
      end
    end

    context 'and the product has dedication and recognition, ' do
      before do
        session[:cart] = { '1' => { 'dedication' => '1_dedication', 'recognition' => '1_recognition' }, '2' => { 'dedication' => '2_dedication', 'recognition' => '2_recognition' } }
        @cart = Product.find(session[:cart].keys)
      end
      it 'renders all products in the cart' do
        render
        expect(rendered).to have_content('$1,500.39', count: 2)
        expect(rendered).to have_content('Total price: $3,000.78')
        expect(rendered).to have_selector('img', count: 4)
        assert_select 'div>a', text: 'Title'.to_s, count: 2
        assert_select 'div>label', text: 'Dedication:'.to_s, count: 2
        assert_select 'div>label', text: 'Recognition:'.to_s, count: 2
        assert_select 'div>input', count: 5
        assert_select 'div>input[name="1_dedication"][value="1_dedication"]'
        assert_select 'div>input[name="2_dedication"][value="2_dedication"]'
        assert_select 'div>input[name="1_recognition"][value="1_recognition"]'
        assert_select 'div>input[name="2_recognition"][value="2_recognition"]'
      end
    end
  end
end
