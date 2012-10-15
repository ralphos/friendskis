class WelcomeController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: :subscription

  layout 'welcome' 
  
  def index
    users = User.recent.slice(-4, 4)
    @user1 = users[0]
    @user2 = users[1]
    @user3 = users[2]
    @user4 = users[3]
  end 

  def subscription
    render layout: false
  end

end
