require('rails_helper')

RSpec.describe('products/new', type: :view) do
  before(:each) do
    assign(
      :product,
      Product.new(
        title: 'MyString',
        author: 'MyString',
        pub_year: 'MyString',
        category: 'MyString',
        image: 'MyString',
        library: 'MyString',
        description: 'MyString',
        condition_treatment: 'MyString',
        adopt_status: 1,
        adopt_amount: '1500.39',
        release_year: 2020,
        dedication: 'MyString',
        recognition: 'MyString',
        adopter_fname: 'MyString',
        adopter_lname: 'MyString',
        adopter_address: 'MyString',
        adopter_phone: 1,
        adopter_email: 'MyString'
      )
    )
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
