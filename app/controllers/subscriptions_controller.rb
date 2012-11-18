class SubscriptionsController < ApplicationController

  def update
    @user = current_user
    if params[:subscription_id].present?
      if @user.update_attributes({subscription_id: params[:subscription_id], subscription_status: params[:subscription_status]})
        SubscriptionMailer.subscription_email(@user).deliver
        render json: {success: true}
      else
        render json: {success: false}
      end
    else
      render json: {success: false}
    end

  end

end
