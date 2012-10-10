require 'spec_helper'

describe PhotosController do

  describe "Like" do

    let(:photo) {
      FactoryGirl.create(:photo)     
    }

    it "should like" do
      post :like, id: photo.id

      response.should be_redirect
    end
  end

end
