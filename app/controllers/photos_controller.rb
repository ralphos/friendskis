class PhotosController < ApplicationController
  
  def pick_album
    @albums = current_user.albums
  end
  
  def album_photos
    @album_photos = current_user.album_photos(params[:album_id])
  end
  
  def add_caption
    @photo = Photo.new
    @thumbnail_url = params[:thumbnail_url]
    @medium_url = params[:medium_url]
  end
  
  def create
    @photo = Photo.new(params[:photo])
    @photo.user_id = current_user.id
    @photo.rank_updated_at = DateTime.now
    if @photo.save
      if @photo.profile_pic == true
        current_user.update_attributes(profile_pic: @photo.id)
      end
      redirect_to user_url(current_user), notice: "Your photo has been added! Other users will start seeing this photo shortly."

    else
       @thumbnail_url = params[:photo][:thumbnail_url]
       @medium_url = params[:photo][:medium_url]
       render 'add_caption'
    end
  end

  def like
    @photo = Photo.find(params[:id])
    if @photo.like!(current_user)
    end

    respond_to do |format| 
      format.js {
        render js: "$('##{dom_id(@photo, 'like')}').html('You thought this photo was cool')" 
      }
      format.html { redirect_to users_url }
    end
  end
end
