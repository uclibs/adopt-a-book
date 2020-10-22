# CartController manages cart session for every adopter
class CartController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_if_session_exists

  def index
    @cart = Product.find(session[:cart].keys)
  end

  def remove
    id = params[:id]
    session[:cart].delete(id)
    redirect_to cart_path
  end

  def destroy
    %i[cart expires_at visit_count].each { |x| session.delete(x) }
    redirect_to root_path
  end

  def checkout
    params.each do |key, value|
      next unless key.include? '_'

      id = key.split('_')[0]
      if key.include? 'dedication'
        session[:cart][id][:dedication] = value
      elsif key.include? 'recognition'
        session[:cart][id][:recognition] = value
      end
    end
    redirect_to root_path
  end

  private

  def check_if_session_exists
    redirect_to root_path, alert: 'Session expired!' if session[:cart].nil?
  end
end
