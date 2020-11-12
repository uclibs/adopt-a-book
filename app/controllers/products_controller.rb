# ProductsController controls CRUD operations of the products
class ProductsController < ApplicationController
  before_action :authenticate_admin!, except: %i[show index add]
  before_action :set_product, only: %i[show edit update destroy]
  before_action :cart_session_exists?, only: :add
  # skip_before_action :verify_authenticity_token, only: :action?
  # GET /products
  # GET /products.json
  def index
    @products = if Product.adopt_statuses.key? params['status'] # security check that it's a valid param
                  Product.send(params['status'])
                else
                  Product.available # if not a valid status param, just return available products
                end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @adopter = Adopter.find(@product.adopter_id) unless @product.adopter_id.nil?
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add
    return unless session[:cart]

    id = params[:id]
    Product.find(id).update(adopt_status: Product.adopt_statuses[:pending])
    session[:cart][id] = {} unless session[:cart].key?(id)
    redirect_back(fallback_location: :product)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:title, :author, :pub_year, :category, :image, :library, :description, :condition_treatment, :adopt_status, :adopt_amount, :release_year, :dedication, :recognition)
  end
end
