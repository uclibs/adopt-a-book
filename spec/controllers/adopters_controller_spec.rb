require 'rails_helper'
require 'spec_helper'

RSpec.describe AdoptersController, type: :controller do
  before do
    admin = FactoryBot.create(:admin)
    @adopter = FactoryBot.create(:adopter)
    sign_in_admin(admin)
  end

  def sign_in_admin(admin)
    sign_in admin
  end

  let(:valid_attributes) do
    {
      fname: 'First Name',
      lname: 'Last Name',
      address: 'Address',
      phone: '123-456-7890',
      email: 'adopter@example.com',
      product_id: '1'
    }
  end

  let(:invalid_attributes) do
    # todo
  end

  let(:valid_session) { {} }

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: @adopter.to_param }
      expect(response).to(be_successful)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          fname: 'First Name',
          lname: 'Last Name',
          address: 'Address',
          phone: '123-456-7890',
          email: 'adopter@example.com'
        }
      end

      it 'updates the requested Adopter' do
        put :update, params: { id: @adopter.to_param, adopter: new_attributes }
        expect(@adopter.fname).to(eq('First Name'))
        expect(@adopter.lname).to(eq('Last Name'))
        expect(@adopter.address).to(eq('Address'))
        expect(@adopter.phone).to(have_content('123-456-7890'))
        expect(@adopter.email).to(have_content('adopter@example.com'))
      end
    end

    it 'redirects to the product' do
      put :update, params: { id: @adopter.to_param, adopter: valid_attributes }
      expect(response).to redirect_to(product_path)
    end
  end
end
