require('rails_helper')

RSpec.describe('products/index', type: :view) do
  before(:each) do
    assign(
      :products,
      [
        Product.create!(
          title: 'Title',
          author: 'Author',
          pub_year: 'Pub Year',
          category: 'Category',
          image: 'Image',
          library: 'Library',
          description: 'Description',
          condition_treatment: 'Condition Treatment',
          adopt_status: 2,
          adopt_amount: '1500.39',
          release_year: 2020,
          dedication: 'Dedication',
          recognition: 'Recognition',
          adopter_fname: 'Adopter Fname',
          adopter_lname: 'Adopter Lname',
          adopter_address: 'Adopter Address',
          adopter_phone: 1_234_567_890,
          adopter_email: 'Adopter Email'
        ),
        Product.create!(
          title: 'Title',
          author: 'Author',
          pub_year: 'Pub Year',
          category: 'Category',
          image: 'Image',
          library: 'Library',
          description: 'Description',
          condition_treatment: 'Condition Treatment',
          adopt_status: 2,
          adopt_amount: '1500.39',
          release_year: 2020,
          dedication: 'Dedication',
          recognition: 'Recognition',
          adopter_fname: 'Adopter Fname',
          adopter_lname: 'Adopter Lname',
          adopter_address: 'Adopter Address',
          adopter_phone: 1_234_567_890,
          adopter_email: 'Adopter Email'
        )
      ]
    )
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
    it 'should not allow admin to see edit, delete and new product links' do
      render
      expect(rendered).to have_no_link('Edit')
      expect(rendered).to have_no_link('Destroy')
      expect(rendered).to have_no_link('New Product')
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
      expect(rendered).to have_link('New Product', count: 1)
    end
  end
end
