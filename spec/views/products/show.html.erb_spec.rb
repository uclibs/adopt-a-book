require('rails_helper')

RSpec.describe('products/show', type: :view) do
  before(:each) do
    @product = FactoryBot.create(:product)
  end

  describe 'when product is not added to cart' do
    it 'renders attributes in <p>' do
      render
      expect(rendered).to(match(/Title/))
      expect(rendered).to(match(/Author/))
      expect(rendered).to(match(/Pub Year/))
      expect(rendered).to(match(/Category/))
      expect(rendered).to(match(/Image/))
      expect(rendered).to(match(/Library/))
      expect(rendered).to(match(/Description/))
      expect(rendered).to(match(/Condition Treatment/))
      expect(rendered).to(match(/2/))
      expect(rendered).to(match(/1,500.39/))
      expect(rendered).to(match(/2020/))
      expect(rendered).not_to(match(/Added to cart/))
      expect(rendered).to have_no_link('View cart')
      expect(rendered).to have_no_link('Adopt more books')
      expect(rendered).to have_link('Add to cart')
    end
  end

  describe 'when product is added to cart' do
    before do
      session[:cart] = { '1' => {} }
    end

    it 'renders attributes in <p>' do
      render
      expect(rendered).to(match(/Title/))
      expect(rendered).to(match(/Author/))
      expect(rendered).to(match(/Pub Year/))
      expect(rendered).to(match(/Category/))
      expect(rendered).to(match(/Image/))
      expect(rendered).to(match(/Library/))
      expect(rendered).to(match(/Description/))
      expect(rendered).to(match(/Condition Treatment/))
      expect(rendered).to(match(/2/))
      expect(rendered).to(match(/1,500.39/))
      expect(rendered).to(match(/2020/))
      expect(rendered).to(match(/Added to cart/))
      expect(rendered).to have_link('View cart', href: cart_path)
      expect(rendered).to have_link('Adopt more books', href: products_path)
      expect(rendered).to have_no_link('Add to cart')
    end
  end

  context 'when admin is not logged in' do
    it 'should not allow admin/adopters to see edit link' do
      render
      expect(rendered).to have_no_link('Edit', href: edit_product_path(@product))
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

    it 'should allow admin to see edit link' do
      render
      expect(rendered).to have_link('Edit', href: edit_product_path(@product))
    end
  end
end
