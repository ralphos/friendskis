require 'spec_helper'

describe User do
  describe "Creation" do
    let(:user) {
      FactoryGirl.create(:user)
    }

    it "should create" do
      user.should be_persisted
    end
  end
end
