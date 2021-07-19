require('rails_helper')

RSpec.describe('products/edit', type: :view) do
  before(:each) do
    @product = FactoryBot.create(:product)
  end

  it 'renders the edit product form' do
    render

    assert_select 'form[action=?][method=?]', product_path(@product), 'post' do
      assert_select 'input[name=?]', 'product[title]'

      assert_select 'input[name=?]', 'product[author]'

      assert_select 'input[name=?]', 'product[pub_year]'

      assert_select 'select[name=?]', 'product[category]'

      assert_select 'input[name=?]', 'product[image]'

      assert_select 'select[name=?]', 'product[library]'

      assert_select 'input[name=?]', 'product[description]'

      assert_select 'input[name=?]', 'product[condition_treatment]'

      assert_select 'select[name=?]', 'product[adopt_status]'

      assert_select 'input[name=?]', 'product[adopt_amount]'

      assert_select 'input[name=?]', 'product[release_year]'

      assert_select 'input[name=?]', 'product[dedication]'

      assert_select 'input[name=?]', 'product[recognition]'
    end
  end
end
