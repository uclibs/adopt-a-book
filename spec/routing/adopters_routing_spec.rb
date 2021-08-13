require('rails_helper')

RSpec.describe(AdoptersController, type: :routing) do
  describe 'routing' do
    it 'routes to #edit' do
      expect(get: '/adopters/1/edit').to(route_to('adopters#edit', id: '1'))
    end

    it 'routes to #update via PUT' do
      expect(put: '/adopters/1').to(route_to('adopters#update', id: '1'))
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/adopters/1').to(route_to('adopters#update', id: '1'))
    end
  end
end
