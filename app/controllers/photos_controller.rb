class PhotosController < ApplicationController
  
  def new
    @photos = current_user.get_photos
  end
  
  def preview
    @photo = Photo.new
    @photo_url = params[:photo_url]
  end
  
  def create
    @photo = Photo.new(params[:photo])
    @photo.user_id = current_user.id
    if @photo.save
      redirect_to users_url
    else
      flash.now.alert = "Sorry there was an error saving your post"
      render :back
    end
  end
end