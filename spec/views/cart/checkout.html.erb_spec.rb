require('rails_helper')

RSpec.describe('cart/checkout', type: :view) do
  before(:each) do
    @products = FactoryBot.create_list(:product, 2)
  end

  describe 'renders checkout page' do
    context 'when the products have dedication and recognition' do
      before do
        session[:cart] = { '1' => { 'dedication' => '1_dedication', 'recognition' => '1_recognition' }, '2' => { 'dedication' => '2_dedication', 'recognition' => '2_recognition' } }
        @cart = Product.find(session[:cart].keys)
      end

      it 'renders adopter form and products in the cart (title along with dedication and recognition)' do
        render
        assert_select 'h1', text: 'Adopter information form'
        assert_select 'p', text: 'Please review the information below. If any changes are needed, click on cart icon in the header to make corrections and checkout again.'
        assert_select 'h3', text: 'Adopted books:'
        assert_select 'b', text: 'Title', count: 2
        assert_select 'div>b>label', text: 'Dedication:'.to_s, count: 2
        assert_select 'div>b>label', text: 'Recognition:'.to_s, count: 2
        expect(rendered).to have_content('1_dedication')
        expect(rendered).to have_content('1_recognition')
        expect(rendered).to have_content('2_dedication')
        expect(rendered).to have_content('2_recognition')
        expect(rendered).to have_content('Total amount to be paid: $3,000.78')
        assert_select 'p', text: 'Please fill out all information'
        assert_select 'div>label', count: 5
        assert_select 'div>input', count: 6
      end
    end

    context 'when the products does not have dedication and recognition' do
      before do
        session[:cart] = { '1' => {}, '2' => {} }
        @cart = Product.find(session[:cart].keys)
      end

      it 'renders adopter form and products in the cart (only title)' do
        render
        assert_select 'h1', text: 'Adopter information form'
        assert_select 'p', text: 'Please review the information below. If any changes are needed, click on cart icon in the header to make corrections and checkout again.'
        assert_select 'h3', text: 'Adopted books:'
        assert_select 'b', text: 'Title', count: 2
        expect(rendered).to have_no_content('Dedication')
        expect(rendered).to have_no_content('Recognition')
        expect(rendered).to have_content('Total amount to be paid: $3,000.78')
        assert_select 'p', text: 'Please fill out all information'
        assert_select 'div>label', count: 5
        assert_select 'div>input', count: 6
      end
    end
  end
end
