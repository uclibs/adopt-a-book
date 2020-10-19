# ProductsController controls CRUD operations of the products
class ProductsController < ApplicationController
  before_action :authenticate_admin!, except: %i[show index add]
  before_action :set_product, only: %i[show edit update destroy]
  # skip_before_action :verify_authenticity_token, only: :action?
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show; end

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
    if session[:cart]
      id = params[:id]
      session[:cart][id] = {} unless session[:cart].key?(id)
      redirect_back(fallback_location: :product)
    else
      redirect_to root_path, alert: 'Session expired!'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:title, :author, :pub_year, :category, :image, :library, :description, :condition_treatment, :adopt_status, :adopt_amount, :release_year, :dedication, :recognition, :adopter_fname, :adopter_lname, :adopter_address, :adopter_phone, :adopter_email, :adopt_time)
  end
end
