class PhotosController < ApplicationController
  
  def new
    @profile_photos = current_user.get_profile_photos
  end
  
  def confirm
    @photo_url = params[:photo_url]
  end
end