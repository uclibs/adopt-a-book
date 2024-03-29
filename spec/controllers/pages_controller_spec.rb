RSpec.describe PagesController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Page. As you add validations to Page, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PagesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      Page.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      page = Page.create! valid_attributes
      get :show, params: { id: page.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    context 'when the user is not logged in' do
      it 'returns an unsuccessful response' do
        get :new, params: {}, session: valid_session
        expect(response).not_to be_successful
      end
    end
    context 'when the user is logged in' do
      before do
        admin = FactoryBot.create(:admin)
        sign_in(admin)
      end
      it 'returns a success response' do
        get :new, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      page = Page.create! valid_attributes
      get :edit, params: { id: page.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Page' do
        expect do
          post :create, params: { page: valid_attributes }, session: valid_session
        end.to change(Page, :count).by(1)
      end

      it 'redirects to the created page' do
        post :create, params: { page: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Page.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { page: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested page' do
        page = Page.create! valid_attributes
        put :update, params: { id: page.to_param, page: new_attributes }, session: valid_session
        page.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the page' do
        page = Page.create! valid_attributes
        put :update, params: { id: page.to_param, page: valid_attributes }, session: valid_session
        expect(response).to redirect_to(page)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        page = Page.create! valid_attributes
        put :update, params: { id: page.to_param, page: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested page' do
      page = Page.create! valid_attributes
      expect do
        delete :destroy, params: { id: page.to_param }, session: valid_session
      end.to change(Page, :count).by(-1)
    end

    it 'redirects to the pages list' do
      page = Page.create! valid_attributes
      delete :destroy, params: { id: page.to_param }, session: valid_session
      expect(response).to redirect_to(pages_url)
    end
  end
end
