require 'spec_helper'

describe HomeController do
  context "/" do
    it "is routable" do
      expect(get: '/').to be_routable
    end
  end
end
