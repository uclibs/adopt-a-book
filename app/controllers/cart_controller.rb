# CartController manages cart session for every adopter
class CartController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_cart, only: %i[index checkout]
  before_action :set_adopter

  def index; end

  def remove
    id = params[:id]
    session[:cart].delete(id)
    Product.find(id).available!
    redirect_to cart_path
  end

  def destroy
    Product.where(id: session[:cart].keys).update_all(adopt_status: Product.adopt_statuses[:available])
    %i[cart expires_at].each { |x| session.delete(x) }
    redirect_to root_path
  end

  def checkout
    params.except(:utf8, :authenticity_token, :commit).each do |key, value|
      next unless key.include? '_'

      id = key.split('_')[0]
      if key.to_s.include? 'dedication'
        session[:cart][id]['dedication'] = value.presence
      elsif key.to_s.include? 'recognition'
        session[:cart][id]['recognition'] = value.presence
      end
    end
  end

  def payment
    return unless adopter_exists? && @adopter.save

    session[:cart].keys.each do |id|
      Product.find(id).update(adopter_id: @adopter.id, adopt_status: Product.adopt_statuses[:pending], adopt_time: Time.now, dedication: session[:cart][id]['dedication'], recognition: session[:cart][id]['recognition'])
    end
    send_emails
    %i[cart expires_at].each { |x| session.delete(x) }
    redirect_to root_path, notice: 'Adopt success!'
  end

  private

  def set_cart
    @cart = Product.find(session[:cart].keys)
  end

  def adopt_params
    params.permit(:fname, :lname, :address, :phone, :email)
  end

  def set_adopter
    @adopter = Adopter.new(adopt_params)
    @adopter = Adopter.find_by 'fname = ? AND lname = ? AND address = ? AND email = ? AND phone = ?', params[:fname], params[:lname], params[:address], params[:email], params[:phone] unless @adopter.valid?
  end

  def adopter_exists?
    @adopter
  end

  def send_emails
    AdoptionMailer.with(adopter: @adopter, product_count: session[:cart].keys.count).thank_you_email.deliver_now
    AdoptionMailer.with(product_ids: session[:cart].keys, adopter: @adopter).adoption_notification_email.deliver_now
  end
end
