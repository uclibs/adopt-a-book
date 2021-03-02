require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET /event' do
    it 'works!' do
      get event_path
      expect(response).to have_http_status(301)
    end
  end
end
