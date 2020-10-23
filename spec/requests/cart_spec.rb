require('rails_helper')

RSpec.describe('Cart', type: :request) do
  describe 'GET /cart' do
    it 'works!' do
      get cart_path
      expect(response).to(have_http_status(200))
    end
  end
end
