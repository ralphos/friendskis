require 'spec_helper'

describe SubscriptionsController do

  let(:user) { FactoryGirl.create(:user) }

  describe "POST create" do
    it "creates a new subscription for a user" do
      user.should_receive(:update_attributes).with("subscription_id" => "123", "subscription_status" => "active")
      post :create, :user => { "subscription_id" => "123", "subscription_status" => "active" }
    end

    it "saves the subscription id & status" do
      user.should_receive(:save)
      post :create
    end

  end

end
