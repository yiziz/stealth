require 'spec_helper'

describe User do
  
  let(:user) { build_stubbed(:user) }
  
  before do
  end

  context "when password confirmation not equal" do
    it "is invalid" do
      user.password = 'a'
      user.password_confirmation = 'b'
      user.valid?
      expect(user).to have(1).error_on(:password_confirmation)
    end
  end
  
  context "when password confirmation equal" do
    it "is valid" do
      user.password = 'a'
      user.password_confirmation = 'a'
      user.valid?
      expect(user).to have(:no).error_on(:password_confirmation)
    end
  end

end
