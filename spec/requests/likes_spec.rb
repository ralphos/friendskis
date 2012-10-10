require 'spec_helper'

include CommonHelpers

feature "Likes", %q{
  In order to like a photo
  As a user
  I want to like
} do

  background do

    @photo = FactoryGirl.create(:photo)

    @guest = FactoryGirl.create(:user, username: 'other-user', email: 'other-user')

    UserPhoto.create!({user_id: @photo.user.id, photo_id: @photo.id})

    sign_in @guest

    # TODO: Make photos

  end

  scenario "Users Insed" do
    visit users_path
    page.should have_content(@guest.username)
  end

  scenario "Like a photo" do
    click_link("Cool")
    page.should have_content("Cooled")
  end

end
