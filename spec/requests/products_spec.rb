require('rails_helper')

RSpec.describe('Products', type: :request) do
  describe 'GET /products/status/0' do
    it 'works!' do
      get status_products_path(status: 0)
      expect(response).to(have_http_status(200))
    end
  end
end
