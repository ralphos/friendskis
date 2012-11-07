class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create

    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id

    if user.is_first_login? 
      user.get_birthday
      redirect_to step_one_path(signed_request: params[:signed_request])
    elsif user.profile_pic.nil?
      redirect_to step_two_path(signed_request: params[:signed_request])
    else
      redirect_to users_path(signed_request: params[:signed_request])
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path(signed_request: params[:signed_request])
  end

  def test_login
    if Rails.env.test?
      session[:user_id] = params[:user_id]
    end
    redirect_to users_path(signed_request: params[:signed_request])

  end
end
