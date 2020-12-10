require('rails_helper')

RSpec.describe('products/show', type: :view) do
  describe 'when product is available' do
    before do
      @product = FactoryBot.create(:product)
    end

    it 'renders attributes in <p>' do
      render
      expect(rendered).to(match(/Title/))
      expect(rendered).to(match(/Author/))
      expect(rendered).to(match(/Pub Year/))
      expect(rendered).to(match(/Category/))
      expect(rendered).to have_selector('img', count: 1)
      expect(rendered).to(match(/Library/))
      expect(rendered).to(match(/Description/))
      expect(rendered).to(match(/Condition Treatment/))
      expect(rendered).to(match(/1,500.39/))
      expect(rendered).not_to(match(/Added to cart/))
      expect(rendered).to have_no_link('View cart')
      expect(rendered).to have_no_link('Adopt more books')
      expect(rendered).to have_link('Add to cart')
    end
  end

  before do
    @product = FactoryBot.create(:pending_product)
    session[:cart] = { '1' => {} }
  end

  describe 'when product is added to cart and is pending' do
    it 'renders attributes in <p>' do
      render
      expect(rendered).to(match(/Title/))
      expect(rendered).to(match(/Author/))
      expect(rendered).to(match(/Pub Year/))
      expect(rendered).to(match(/Category/))
      expect(rendered).to have_selector('img', count: 1)
      expect(rendered).to(match(/Library/))
      expect(rendered).to(match(/Description/))
      expect(rendered).to(match(/Condition Treatment/))
      expect(rendered).to(match(/1,500.39/))
      expect(rendered).to(match(/Added to cart/))
      expect(rendered).to have_link('View cart', href: cart_path)
      expect(rendered).to have_link('Adopt more books', href: status_products_path(status: 'available'))
      expect(rendered).to have_no_link('Add to cart')
    end
  end

  describe 'when product is adopted' do
    before do
      @product = FactoryBot.create(:adopted_product)
      @adopter = FactoryBot.create(:adopter)
    end

    it 'renders attributes in <p>' do
      render
      expect(rendered).to(match(/Title/))
      expect(rendered).to(match(/Author/))
      expect(rendered).to(match(/Pub Year/))
      expect(rendered).to(match(/Category/))
      expect(rendered).to have_selector('img', count: 2)
      expect(rendered).to(match(/Library/))
      expect(rendered).to(match(/Description/))
      expect(rendered).to(match(/Condition Treatment/))
      expect(rendered).to(match(/Dedication/))
      expect(rendered).to(match(/Recognition/))
      expect(rendered).not_to(match(/Added to cart/))
      expect(rendered).to have_no_link('View cart', href: cart_path)
      expect(rendered).to have_no_link('Adopt more books', href: status_products_path(status: 'available'))
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

    before do
      @product = FactoryBot.create(:adopted_product)
      @adopter = FactoryBot.create(:adopter)
    end

    it 'should allow admin to see author information if product is adopted' do
      render
      expect(rendered).to(match(/First Name/))
      expect(rendered).to(match(/Last Name/))
      expect(rendered).to(match(/Address/))
      expect(rendered).to(match(/1234567890/))
      expect(rendered).to(match(/adopter@example.com/))
      expect(rendered).to(match(/2020-10-27 19:30:54/))
    end
  end
end
