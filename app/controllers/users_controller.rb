class UsersController < ApplicationController
  
  def index
    @photos = UserPhoto.latest_photos(current_user).page(params[:page])
    @message = Message.new
  end
  
  def show
    @user = User.find(params[:id])
    @user_photos = @user.recent_photos.page(params[:page])
    @message = Message.new
    Visitor.find_or_create_by_visitor_id_and_user_id(current_user.id, params[:id]) 
  end
  
  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      respond_to do |w|
        w.html { redirect_to user_url(@user)}
        w.js { render js: "History.pushState(null, 'Profile Page', '#{user_url(@user)}')"}
      end
      flash[:notice] = "Your account has been updated!"
    else
      render :back, notice: "Sorry there was an error updating your account."
    end
  end
end
