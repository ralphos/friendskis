class UsersController < ApplicationController
  
  def index
    @photos = UserPhoto.latest_photos
    @message = Message.new
  end
  
  def show
    @user = User.find(params[:id])
    @photos = @user.latest_user_photos
  end
  
  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      redirect_to account_url, notice: "Your account has been updated!"
    else
      render :back, notice: "Sorry there was an error updating your account."
    end
  end
end