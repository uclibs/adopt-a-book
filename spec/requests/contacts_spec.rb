require('rails_helper')

RSpec.describe('Contacts', type: :request) do
  describe 'GET /contact/new' do
    it 'works!' do
      get new_contact_path
      expect(response).to(have_http_status(200))
    end
  end
end
