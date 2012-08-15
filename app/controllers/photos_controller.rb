class PhotosController < ApplicationController
  
  def new
    @profile_photos = current_user.get_profile_photos
  end
end