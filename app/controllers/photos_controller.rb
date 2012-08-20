class PhotosController < ApplicationController
  
  def new
    @albums = current_user.albums
  end
  
  def album
    @album_photos = current_user.album_photos(params[:album_id])
  end
  
  def preview
    @photo = Photo.new
    @thumbnail_url = params[:thumbnail_url]
    @medium_url = params[:medium_url]
  end
  
  def create
    @photo = Photo.new(params[:photo])
    @photo.user_id = current_user.id
    if @photo.save
      if @photo.profile_pic == true
        current_user.update_attributes(profile_pic: @photo.id)
      end
      redirect_to users_url
    else
      flash.now.alert = "Sorry there was an error saving your post"
      render :back
    end
  end
end