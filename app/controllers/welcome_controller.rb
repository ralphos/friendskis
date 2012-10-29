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
  end 

  def subscription
    render layout: false
  end

end
