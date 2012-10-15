require 'spec_helper'

describe User do
  context "Creation" do
    let(:user) {
      FactoryGirl.create(:user)
    }

    it "should create" do
      user.should be_persisted
    end
  end

  context "Scores" do

    it "should compute score" do

      user = FactoryGirl.create(:user)

      photo1 = user.photos.create(caption: 'photo 1')
      photo2 = user.photos.create(caption: 'photo 2')

      5.times do |i|
        photo1.like!(FactoryGirl.create(:user, email: "liker#{i}@example.com", username: "liker#{i}"))
      end

      3.times do |i|
        photo2.like!(FactoryGirl.create(:user, email: "liker#{i}@example.com", username: "liker#{i + 100}"))
      end

      user.total_likes.should eq(8)

      user.computed_score.should eq(800)

      user.compute_score!

      user.reload

      user.score.should eq(800)

    end

    it "should process overall scores" do


      [1000, 5500, 3200, 1600, 300].each do |s|
        FactoryGirl.create(:user, username: "user#{s}", score: s)
      end

      User.max_score.should eq(5500)

      u = User.where(score: 300).first
      u.compute_percent_score(5500 / 100).should eq(5)

      User.compute_rankings!

      ranked_users = User.order("percent_score desc")
      ranked_users.first.score.should eq(5500)
      ranked_users.last.score.should eq(300)

    end

  end

  context "subscribers" do

    let(:user) { FactoryGirl.create(:user, subscription_status: "active") }
    
    it "should check if a user is subscribed" do
      user.is_subscriber?.should be_true
    end
  end


end
