require 'spec_helper'

describe ApplicationController do
  
  let(:user) { create(:norm_user) }

  controller do
    def index
      render json: []
    end

    # stub correct policy
    def policy(record)
      ApplicationPolicy.send(:define_method, :index?) { true }
      ApplicationPolicy.new(current_user, record)
    end
  end
  
  context 'when authenticating a request' do
    it 'that has no token' do
      get :index
      expect(assigns[:access_token]).to eq(nil)
      expect(assigns[:current_user]).to eq(nil)
    end

    it 'that has an expired token' do
      get_with_user({
        user: user, 
        options: {expires_in: 0.seconds}
      }, :index)
      expect(assigns[:access_token]).to eq(nil)
      expect(assigns[:current_user]).to eq(nil)
    end

    it 'that has an incorrect token' do
      get_with_user({
        user: nil, 
        options: {token: 'FAKE _TOKEN'}
      }, :index)
      expect(assigns[:access_token]).to eq(nil)
      expect(assigns[:current_user]).to eq(nil)
    end

    it 'that has a correct token' do
      get_with_user user, :index
      expect(assigns[:access_token].expires_at - Time.now).to be > (0)
      expect(assigns[:current_user].id).to eq(user.id)
    end
  end
end 
