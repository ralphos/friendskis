require 'spec_helper'

describe Photo do
  describe "Creation" do

    let(:photo) {
      FactoryGirl.create(:photo)
    }

    it "should create" do
      photo.should be_persisted
    end

  end

  describe "Like" do
    let(:photo){
      FactoryGirl.create(:photo) 
    }

    let(:photo2){
      FactoryGirl.create(:photo) 
    }

    let(:user) {
      FactoryGirl.create(:user, username: 'user1', email: 'user1@example.com') 
    }

    let(:user2) {
      FactoryGirl.create(:user, email: 'user2@example.com', username: 'user3') 
    }

    it "user1 should like the photo" do
      lambda {
        photo.like!(user)
      }.should change(Like, :count).by(1)
    end

    it "should raise an error if voted twice" do
      photo.like!(user)

      lambda {
        photo.like!(user)
      }.should raise_exception(ActiveRecord::RecordInvalid)

    end

    it "should return true if liked already" do
      photo.like!(user)
      photo.should be_liked(user)
    end

    it "should set the #rank_updated_at when a photo is created" do
      photo.rank_updated_at.should_not be_nil
    end

    it "should update the #rank_updated_at field when liked" do
      initial_rank_updated_at = photo.rank_updated_at
      photo.like!(user)
      photo.rank_updated_at.should_not eq(initial_rank_updated_at)
    end

    it "should change the rank_updated_at field after subsequent likes" do
      photo.like!(user)
      rank_updated_at = photo.rank_updated_at
      photo.like!(user2)
      new_rank_updated_at = photo.rank_updated_at
      rank_updated_at.should_not eq(new_rank_updated_at)
    end

    it "should sort photos based on #rank_updated_at" do
      photo.like!(user2)
      UserPhoto.latest_photos(user2).first.should == photo
    end

    it "should sort by #rank_updated_at but still show latest photos added on top" do
      photo = FactoryGirl.create(:photo) 
      UserPhoto.latest_photos(user).first.should == photo
    end
  end
end
