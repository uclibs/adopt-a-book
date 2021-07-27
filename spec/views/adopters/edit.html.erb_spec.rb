require('rails_helper')
RSpec.describe('adopters/edit', type: :view) do
  before(:each) do
    @adopter = FactoryBot.create(:adopter)
    allow(view).to receive_message_chain(:request, :referrer).and_return('http://localhost:3000/product/1')
  end

  context 'when admin is logged in' do
    before(:each) do
      admin = FactoryBot.create(:admin)
      sign_in_admin(admin)
    end

    def sign_in_admin(admin)
      sign_in admin
    end

    it 'should allow admin to see adopter information if product is adopted' do
      render
      expect(rendered).to(match(/#{@adopter.fname}/))
      expect(rendered).to(match(/#{@adopter.lname}/))
      expect(rendered).to(match(/#{@adopter.address}/))
      expect(rendered).to(match(/#{@adopter.phone}/))
      expect(rendered).to(match(/#{@adopter.email}/))
    end

    it 'renders the edit adopter form' do
      render
      assert_select 'form[action=?][method=?]', adopter_path(@adopter), 'post' do
        assert_select 'input[name=?]', 'adopter[fname]'

        assert_select 'input[name=?]', 'adopter[lname]'

        assert_select 'input[name=?]', 'adopter[address]'

        assert_select 'input[name=?]', 'adopter[phone]'

        assert_select 'input[name=?]', 'adopter[email]'
      end
    end
  end
end
