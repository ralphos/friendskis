class UsersController < ApplicationController
  
  def index
    @photos = UserPhoto.latest_photos
  end
  
  def show
    @user = current_user
  end
end