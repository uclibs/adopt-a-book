# ApplicationController manages cart initialization and expiration across all modules
class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :check_session_expiry

  private

  def initialize_session
    session[:cart] ||= {}
  end

  def check_session_expiry
    if !session[:expires_at].nil? && (session[:expires_at] < Time.now)
      Product.where(id: session[:cart].keys).update_all(adopt_status: Product.adopt_statuses[:available])
      reset_session
    else
      session[:expires_at] = ENV['CART_EXPIRY_TIME'].to_i.minutes.from_now
    end
  end

  def cart_session_exists?
    redirect_to root_path, alert: 'Session expired!' if session[:cart].nil?
  end
end
