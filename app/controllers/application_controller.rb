# ApplicationController manages cart initialization and expiration across all modules
class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :initialize_session
  before_action :check_session_expiry

  private

  def initialize_session
    session[:cart] ||= {}
  end

  def check_session_expiry
    if !session[:expires_at].nil? && (session[:expires_at] < Time.now)
      Product.where(id: session[:cart].keys).update_all(adopt_status: Product.adopt_statuses[:available])
      %i[cart expires_at].each { |x| session.delete(x) }
    else
      session[:expires_at] = ENV['CART_EXPIRY_TIME'].to_i.minutes.from_now
    end
  end
end
