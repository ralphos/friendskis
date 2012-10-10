class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id

    if user.is_first_login? 
      user.get_birthday
      redirect_to step_one_path
    elsif user.profile_pic.nil?
      redirect_to step_two_path
    else
      redirect_to users_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def test_login
    if Rails.env.test?
      session[:user_id] = params[:user_id]
    end
    redirect_to users_url
  end
end
