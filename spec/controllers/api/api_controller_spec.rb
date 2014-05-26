require 'spec_helper'

describe Api::ApiController do
  
  context "when render json" do
    it "default" do
      _json = Api::ApiController.new._json
      expect(_json[:status]).to eq('default')
      expect(_json[:data]).to eq(nil)
      expect(_json[:messages]).to eq([])
      expect(_json[:errors]).to eq([])
    end
  end
end
