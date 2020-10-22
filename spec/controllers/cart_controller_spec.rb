require 'rails_helper'

RSpec.describe CartController, type: :controller do
  before do
    session[:cart] = { '1' => {} }
    @product = FactoryBot.create(:product)
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #remove' do
    it 'product is removed from cart' do
      expect do
        delete :remove, params: { id: session[:cart].keys.last.to_param }
      end.to(change(session[:cart], :count).by(-1))
      expect(response).to(redirect_to(cart_url))
    end
  end

  describe 'DELETE #destroy' do
    it 'session is deleted' do
      delete :destroy
      expect(session).to be_empty
    end

    it 'redirects to root page' do
      delete :destroy
      expect(response).to(redirect_to(root_url))
    end
  end

  describe 'POST #checkout' do
    it 'dedication is saved in session for the respective product ID' do
      post :checkout, params: { '1_dedication' => '1_dedication', '1_recognition' => '1_recognition' }
      expect(session[:cart]['1'][:dedication]).to eq '1_dedication'
    end

    it 'recognition is saved in session for the respective product ID' do
      post :checkout, params: { '1_dedication' => '1_dedication', '1_recognition' => '1_recognition' }
      expect(session[:cart]['1'][:recognition]).to eq '1_recognition'
    end
  end
end
