class SubscriptionsController < ApplicationController

  def update
    @user = current_user
    if @user.update_attributes({subscription_id: params[:subscription_id], subscription_status: params[:subscription_status]})
      render json: {success: true}
    else
      render json: {success: false}
    end

  end

end
