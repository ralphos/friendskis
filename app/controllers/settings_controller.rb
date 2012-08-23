class SettingsController < ApplicationController
  
  def account
    @user = current_user
  end
  
  def notifications
  end
  
  def privacy
  end
  
  def credits
  end
  
end