class WizardsController < ApplicationController
  
  def setup
    @user = current_user
  end  
  
  def profile
    @photos = current_user.profile_photos
  end
  
  def confirm
    @photo = Photo.new
    @user = current_user
    @photo_url = params[:photo]
  end
  
  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      redirect_to profile_url
    else
      render :back
    end
  end
end
