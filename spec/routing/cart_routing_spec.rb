require('rails_helper')

RSpec.describe(CartController, type: :routing) do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/cart').to(route_to('cart#index'))
    end
  end
end
