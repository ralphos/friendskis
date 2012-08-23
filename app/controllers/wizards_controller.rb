class WizardsController < ApplicationController
  
  def step_one
    @user = current_user
  end  
  
  def step_two
    @photos = current_user.profile_photos
  end
  
  def step_three
    @photo = Photo.new
    @user = current_user
    @photo_url = params[:photo]
  end
  
  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      redirect_to step_two_url
    else
      render :back
    end
  end
end
