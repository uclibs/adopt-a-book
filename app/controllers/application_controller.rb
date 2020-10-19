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
      reset_session
    else
      session[:expires_at] = 10.seconds.from_now
    end
  end
end
