require('rails_helper')

RSpec.describe('Products', type: :request) do
  describe 'GET /products/status/:status' do
    it 'works!' do
      get status_products_path(status: 'available')
      expect(response).to(have_http_status(200))
    end
  end
end
