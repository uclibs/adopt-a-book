require('rails_helper')

RSpec.describe('products/show', type: :view) do
  before(:each) do
    @product = assign(
      :product,
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
    )
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
  end
end
