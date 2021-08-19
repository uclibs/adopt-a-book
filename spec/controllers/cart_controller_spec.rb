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
			expect(session[:cart]['1']['dedication']).to eq '1_dedication'
		end

		it 'recognition is saved in session for the respective product ID' do
			post :checkout, params: { '1_dedication' => '1_dedication', '1_recognition' => '1_recognition' }
			expect(session[:cart]['1']['recognition']).to eq '1_recognition'
		end
	end

	describe 'POST #payment' do
		it 'product and adopter details are saved in DB' do
			post :payment, params: { 'fname' => 'First Name', 'lname' => 'Last Name', 'address' => 'Address', 'email' => 'adopter@exapmple.com', 'phone' => '123-456-7890' }
			expect(Product.find(1).adopt_status).to eq 'pending'
			expect(Product.find(1).adopter_id).to eq 1
			expect(Product.find(1).dedication).to be_nil
			expect(Product.find(1).recognition).to be_nil
			expect(Adopter.find(1).fname).to eq 'First Name'
			expect(Adopter.find(1).lname).to eq 'Last Name'
			expect(Adopter.find(1).address).to eq 'Address'
			expect(Adopter.find(1).phone).to eq '123-456-7890'
			expect(Adopter.find(1).email).to eq 'adopter@exapmple.com'
			expect(ActionMailer::Base.deliveries.count).to eq 2
		end
	end
end
