class WelcomeController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: :subscription

  layout 'welcome' 
  
  def index
    if user_signed_in?
      redirect_to users_path
      return
    end

    if Rails.env == "production" && params[:signed_request].blank?
      redirect_to "https://apps.facebook.com/friendskis/"
      return
    end

    if User.all.size >= 5
      users = User.recent.slice(-4, 4)
      @user1 = users[0]
      @user2 = users[1]
      @user3 = users[2]
      @user4 = users[3]
    end
  end 

  def subscription
    render layout: false
  end

end
