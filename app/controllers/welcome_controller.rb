class WelcomeController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: :subscription

  layout 'welcome' 
  
  def index
    if Rails.env == "production" # && params[:signed_request].blank?
      redirect_to "https://apps.facebook.com/friendskis/"
      return
    else 
      redirect_to_users_path
    end

    #if user_signed_in?
      #redirect_to users_path
      #return
#    end 
  end

  def subscription
    render layout: false
  end

end
