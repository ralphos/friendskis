class WelcomeController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: :subscription

  layout 'welcome' 
  
  def index

    if Rails.env == "production" && params[:signed_request].blank?
      if user_signed_in?
        session[:user_id] = current_user.id
      end

      redirect_to "https://apps.facebook.com/friendskis/"
      return
    end

    #if params[:signed_request].present?
      #redirect_to "/auth/facebook/?signed_request=#{params[:signed_request]}"
      #return
    #end

    if user_signed_in?
      redirect_to users_path
      return
    end 
  end

  def subscription
    render layout: false
  end

  def channel
    cache_expire = 1.year
    response.headers["Pragma"] = "public"
    response.headers["Cache-Control"] = "max-age=#{cache_expire.to_i}"
    response.headers["Expires"] = (Time.now + cache_expire).strftime("%d %m %Y %H:%I:%S %Z")
    render :layout => false, :inline => "<script src='//connect.facebook.net/en_US/all.js'></script>"
    if user_signed_in?
      session[:user_id] = current_user.id
    end
  end

end
