require 'rails_helper'

RSpec.describe PagesController, type: :routing do
  describe 'routing', except: 'index' do
    it 'GET /event', type: :request do
      get '/event'
      expect(response).to redirect_to('/pages/2')
    end
    it 'GET /donors', type: :request do
      get '/donors'
      expect(response).to redirect_to('/pages/3')
    end
    it 'routes to #new' do
      expect(get: '/pages/new').to route_to('pages#new')
    end

    it 'routes to #show' do
      expect(get: '/pages/1').to route_to('pages#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/pages/1/edit').to route_to('pages#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/pages').to route_to('pages#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/pages/1').to route_to('pages#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/pages/1').to route_to('pages#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/pages/1').to route_to('pages#destroy', id: '1')
    end
  end
end