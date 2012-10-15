require 'spec_helper'


describe SubscriptionsController do

  let(:user) { FactoryGirl.create(:user) }

  describe "POST create" do

    it "saves the subscription id & status" do
      
      session[:user_id] = user.id

      xhr :put, :update, "subscription_id" => "123", "subscription_status" => "active" 

      u = assigns(:user)

      u.reload

      u.subscription_id.should eq("123")
      u.subscription_status.should eq("active")


      output = JSON.parse(response.body)
      output["success"].should == true

      response.should be_success

    end

  end

end
