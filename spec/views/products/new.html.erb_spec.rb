require('rails_helper')

RSpec.describe('products/new', type: :view) do
  before(:each) do
    @product = FactoryBot.build(:product)
  end

  it 'renders new product form' do
    render

    assert_select 'form[action=?][method=?]', products_path, 'post' do
      assert_select 'input[name=?]', 'product[title]'

      assert_select 'input[name=?]', 'product[author]'

      assert_select 'input[name=?]', 'product[pub_year]'

      assert_select 'input[name=?]', 'product[category]'

      assert_select 'input[name=?]', 'product[image]'

      assert_select 'input[name=?]', 'product[library]'

      assert_select 'input[name=?]', 'product[description]'

      assert_select 'input[name=?]', 'product[condition_treatment]'

      assert_select 'input[name=?]', 'product[adopt_status]'

      assert_select 'input[name=?]', 'product[adopt_amount]'

      assert_select 'input[name=?]', 'product[release_year]'

      assert_select 'input[name=?]', 'product[dedication]'

      assert_select 'input[name=?]', 'product[recognition]'

      assert_select 'input[name=?]', 'product[adopter_fname]'

      assert_select 'input[name=?]', 'product[adopter_lname]'

      assert_select 'input[name=?]', 'product[adopter_address]'

      assert_select 'input[name=?]', 'product[adopter_phone]'

      assert_select 'input[name=?]', 'product[adopter_email]'
    end
  end
end
