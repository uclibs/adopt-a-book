require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  include ActiveSupport::Testing::TimeHelpers

  describe 'initialize_session method' do
    @controller = ApplicationController.new
    it 'initializes cart session' do
      @controller.instance_eval { initialize_session }
      expect(session[:cart]).to be_empty
    end
  end

  describe 'check_session_expiry method' do
    @controller = ApplicationController.new
    it 'initializes expiry session' do
      @controller.instance_eval { check_session_expiry }
      expect(@controller.instance_eval { session[:expires_at] }).to be_within(1.second).of(10.seconds.from_now)
    end

    before do
      session[:cart] = { '1' => {} }
      @product = FactoryBot.create(:pending_product)
      @controller.instance_eval { initialize_session }
      @controller.instance_eval { check_session_expiry }
      travel_to(11.seconds.from_now)
      @controller.instance_eval { check_session_expiry }
    end

    it 'changes adopt status of the products in the cart to available' do
      expect(Product.find(1).adopt_status).to eq('available')
    end

    it 'resets session after 30 minutes' do
      expect(session).to be_empty
    end
  end
end
