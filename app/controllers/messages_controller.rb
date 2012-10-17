class MessagesController < ApplicationController
  
  def new
    @message = Message.new
    @recipients_id = params[:recipients_id]
    @recipients_username = params[:recipients_username]
  end
  
  def create
    # NEED TO REFACTOR. THIS SUCKS.
    if Conversation.where(sender_id: params[:message][:recipients_id], recipient_id: current_user.id).present?
      conversation = Conversation.where(sender_id: params[:message][:recipients_id], recipient_id: current_user.id).first
    else
      conversation = Conversation.where(sender_id: current_user.id, recipient_id: params[:message][:recipients_id]).first_or_initialize
      conversation.save
    end
    conversation.update_attribute(:updated_at, Time.now)
    @message = Message.new(params[:message])
    @message.conversation_id = conversation.id
    @message.user_id = current_user.id
    if @message.save
      redirect_to conversation_path(@message.conversation)
    else
      redirect_to user_path(params[:message][:recipients_id])
    end
  end
  
end
