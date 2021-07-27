# AdoptersController controls CRUD operations of the products
class AdoptersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_adopter, only: %i[edit update]
  skip_before_action :verify_authenticity_token

  def edit
    @adopter = Adopter.find(params[:id])
  end

  def update
    @adopter.update(adopt_params)
    redirect_to product_path(id: referring_product), notice: 'Adopter Details Was Successfully Updated'
  end
end

private
# Use callbacks to share common setup or constraints between actions.
def set_adopter
  @adopter = Adopter.find(params[:id])
end

def referring_product
  params['adopter']['product_id'].to_i
end

def adopt_params
  params.require(:adopter).permit(:fname, :lname, :address, :phone, :email)
end
