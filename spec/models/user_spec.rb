require 'spec_helper'

describe User do

  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without a username" do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end

  it "is invalid with a username that is too short" do
    FactoryGirl.build(:user, username: "yo").should_not be_valid
  end

  it "is invalid with a username that is too long" do
    FactoryGirl.build(:user, username: "thissssssssuserrrrrnameeeeissstooooloooonnggggg").should_not be_valid
  end

  it "is invalid with a username that is not unique" do
    FactoryGirl.create(:user, username: "ralphos")
    FactoryGirl.build(:user, username: "ralphos").should_not be_valid
  end

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

    it "should only compute scores based on likes created_at in the last week" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user, email: "some@email.com", username: "ralphy")
      photo = user1.photos.create(caption: "My photo")
      like = FactoryGirl.create(:like, user: user2, photo: photo, created_at: 2.weeks.ago)
      user1.total_likes.should eq(0)
      user1.computed_score.should eq(0)
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
      user.subscriber?.should be_true
    end
  end


end
