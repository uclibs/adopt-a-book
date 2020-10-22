require('rails_helper')

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe(ProductsController, type: :controller) do
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
      adopt_status: 2,
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
    it 'returns a success response' do
      get :index, params: {}, session: valid_session
      expect(response).to(be_successful)
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

    # context 'with invalid params' do
    #   it "returns a success response (i.e. to display the 'new' template)" do
    #     post :create, params: { product: invalid_attributes }, session: valid_session
    #     expect(response).to be_successful
    #   end
    # end
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
          adopt_status: 1,
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
        expect(@product.adopt_status).to(have_content(1))
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

    # context 'with invalid params' do
    #   it "returns a success response (i.e. to display the 'edit' template)" do
    #     product = Product.create! valid_attributes
    #     put :update, params: { id: product.to_param, product: invalid_attributes }, session: valid_session
    #     expect(response).to be_successful
    #   end
    # end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested product' do
      expect do
        delete :destroy, params: { id: @product.to_param }, session: valid_session
      end.to(change(Product, :count).by(-1))
    end

    it 'redirects to the products list' do
      delete :destroy, params: { id: @product.to_param }, session: valid_session
      expect(response).to(redirect_to(products_url))
    end
  end

  describe 'POST #add' do
    it 'product is added to cart' do
      expect do
        post :add, params: { id: @product.to_param }, session: valid_session
      end.to(change(session[:cart], :count).by(1))
      expect(response).to(redirect_to(@product))
    end
  end
end
