class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if user.username.nil?
      redirect_to setup_path
    else
      redirect_to users_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
