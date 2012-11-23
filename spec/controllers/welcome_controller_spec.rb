require 'spec_helper'

describe WelcomeController do

  describe 'facebook app request callback' do

    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      user.invites.create(fb_uid: "12345", fb_request_id: "54321", concat_request_field: "54321_12345")
      user.invites.create(fb_uid: "11111", fb_request_id: "22222", concat_request_field: "22222_11111")
    end

    it "deletes an app request" do
      get :index, request_ids = "54321, 22222"
      expect(response.success).to eq(true)
    end
  end
end
