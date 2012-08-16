class UsersController < ApplicationController
  
  def index
    @posts = UserPhoto.latest_photos
  end
end