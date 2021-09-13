RSpec.describe(ProductsController, type: :controller) do
  render_views
  before do
    admin = FactoryBot.create(:admin)
    @product = FactoryBot.create(:product)
    sign_in_admin(admin)
    session[:cart] = {}
  end

  def sign_in_admin(admin)
    sign_in admin
  end

  # This should return the minimal set of attributes required to create a valid
  # Product. As you add validations to Product, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      title: 'Title',
      author: 'Author',
      pub_year: 'Pub Year',
      category: 'Category',
      image: 'Image',
      library: 'Library',
      description: 'Description',
      condition_treatment: 'Condition Treatment',
      adopt_status: 'pending',
      adopt_amount: '1500.39',
      release_year: 2020,
      dedication: 'Dedication',
      recognition: 'Recognition'
    }
  end

  let(:invalid_attributes) do
    # todo
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProductsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    context 'when status is available' do
      it 'returns a success response for available books' do
        get :index, params: { status: 'available' }, session: valid_session
        expect(@product.adopt_status).to(eq('available'))
        expect(response).to(be_successful)
      end
    end

    context 'when status is adopted' do
      before do
        @product = FactoryBot.create(:adopted_product)
      end

      it 'returns a success response for adopted books' do
        get :index, params: { status: 'adopted' }, session: valid_session
        expect(@product.adopt_status).to(eq('adopted'))
        expect(response).to(be_successful)
      end
    end
  end

  context 'when searching by category' do
    before do
      FactoryBot.create(:adopted_product, title: 'Test Title One', category: 'Build The Collection')
      FactoryBot.create(:adopted_product, title: 'Test Title Two', category: 'Preserve For The Future')
    end
    it 'returns a success response when searching by category' do
      get :index, params: { status: 'adopted', category: 'Build The Collection' }, session: valid_session
      expect(response.body).to have_text('Test Title One')
      expect(response.body).to have_no_text('Test Title Two')
    end
  end

  context 'when searching by library' do
    before do
      FactoryBot.create(:adopted_product, title: 'Test Title Three', library: 'Archives and Rare Books Library')
      FactoryBot.create(:adopted_product, title: 'Test title Four', library: 'John Miller Burnam Classics Library')
    end
    it 'returns a success response when searching by library' do
      get :index, params: { status: 'adopted', library: 'Archives and Rare Books Library' }, session: valid_session
      expect(response.body).to have_text('Test Title Three')
      expect(response.body).to have_no_text('Test Title Four')
    end
  end

  context 'when searching by title' do
    before do
      FactoryBot.create(:adopted_product, title: 'Chinese Central Asia: A Ride to Little Tibet')
      FactoryBot.create(:adopted_product, title: 'The First Book of Architecture')
    end
    it 'returns a success response when searching by title' do
      get :index, params: { status: 'adopted', title: 'The First Book of Architecture' }, session: valid_session
      expect(response.body).to have_text('The First Book of Architecture')
      expect(response.body).to have_no_text('Chinese Central Asia: A Ride to Little Tibet')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: @product.to_param }, session: valid_session
      expect(response).to(be_successful)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to(be_successful)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: @product.to_param }, session: valid_session
      expect(response).to(be_successful)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Product' do
        expect do
          post :create, params: { product: valid_attributes }, session: valid_session
        end.to(change(Product, :count).by(1))
      end

      it 'redirects to the created product' do
        post :create, params: { product: valid_attributes }, session: valid_session
        expect(response).to(redirect_to(Product.last))
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          title: 'Title New',
          author: 'Author New',
          pub_year: 'Pub Year New',
          category: 'Category New',
          image: 'Image New',
          library: 'Library New',
          description: 'Description New',
          condition_treatment: 'Condition Treatment New',
          adopt_status: 'adopted',
          adopt_amount: '2500.99',
          release_year: 2020,
          dedication: 'Dedication New',
          recognition: 'Recognition New'
        }
      end

      it 'updates the requested product' do
        put :update, params: { id: @product.to_param, product: new_attributes }, session: valid_session
        @product.reload
        expect(@product.title).to(eq('Title New'))
        expect(@product.author).to(eq('Author New'))
        expect(@product.pub_year).to(eq('Pub Year New'))
        expect(@product.category).to(eq('Category New'))
        expect(@product.image).to(have_content('Image New'))
        expect(@product.library).to(have_content('Library New'))
        expect(@product.description).to(have_content('Description New'))
        expect(@product.condition_treatment).to(have_content('Condition Treatment New'))
        expect(@product.adopt_status).to(have_content('adopted'))
        expect(@product.adopt_amount).to(have_content('2500.99'))
        expect(@product.release_year).to(have_content(2020))
        expect(@product.dedication).to(eq('Dedication New'))
        expect(@product.recognition).to(have_content('Recognition New'))
      end

      it 'redirects to the product' do
        put :update, params: { id: @product.to_param, product: new_attributes }, session: valid_session
        expect(response).to(redirect_to(@product))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested product' do
      expect do
        delete :destroy, params: { id: @product.to_param }, session: valid_session
      end.to(change(Product, :count).by(-1))
    end

    it 'redirects to the products list' do
      delete :destroy, params: { id: @product.to_param }, session: valid_session
      expect(response).to(redirect_to(status_products_path(status: 'available')))
    end
  end

  describe 'POST #add' do
    context 'when product is available' do
      it 'product is added to cart' do
        expect do
          post :add, params: { id: @product.to_param }, session: valid_session
        end.to(change(session[:cart], :count).by(1))
        @product.reload
        expect(@product.adopt_status).to eq('pending')
        expect(response).to(redirect_to(@product))
      end
    end

    context 'when product is unavailble(in cart of others)' do
      before do
        @product = FactoryBot.create(:pending_product)
      end
      it 'redirects to products available page with unavailable alert' do
        post :add, params: { id: @product.to_param }, session: valid_session
        expect(response).to(redirect_to(status_products_path(status: 'available')))
      end
    end
  end
end
