require 'spec_helper'

describe Api::V1::TokensController do
  
  context "/tokens/authenticate" do
    it "is routable" do
      expect(post: '/api/tokens/authenticate').to be_routable
    end
  end
end
