class UsersController < ApplicationController
  
  def index
    @photos = UserPhoto.latest_photos
  end
end