require 'spec_helper'

describe Like do
  describe "Creation" do

    let(:like) {
      FactoryGirl.create(:like)
    }

    it "should create" do
      #like.persisted? # has an id.
      like.should be_persisted
    end

    it "should belong to a user" do
      like.user.should be_present
    end

    it "should belong to a photo" do

    end

  end
end
