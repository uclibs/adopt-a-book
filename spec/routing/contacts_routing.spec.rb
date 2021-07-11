require('rails_helper')

RSpec.describe(ContactsController, type: :routing) do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/contacts/new').to(route_to('contacts#new'))
    end
    it 'GET /contacts', type: :request do
      get '/contacts'
      expect(response).to redirect_to('/contacts/new')
    end
  end
end
