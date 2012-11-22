require 'spec_helper'

describe InvitesController do

  let(:user) { FactoryGirl.create(:user) }

  describe "POST create" do

    it "receives an array of friend ids in the callback" do
      session[:user_id] = user.id

      expect {
        xhr :post, :create, fb_request_id: "123", "ids" => ['123', '343']
      }.to change{Invite.count}.by(2)

      expect(response.success?).to eq(true)

    end

  end

end
