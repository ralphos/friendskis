class UsersController < ApplicationController
  
  def index
    @photos = UserPhoto.latest_photos
  end
  
  def show
    @user = User.find(params[:id])
  end
end