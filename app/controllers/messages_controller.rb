class MessagesController < ApplicationController
  
  def new
    @message = Message.new
    @recipient = params[:recipient]
  end
  
  def create
    # NEED TO REFACTOR. THIS SUCKS.
    if Conversation.where(sender_id: params[:message][:to], recipient_id: current_user.id).present?
      conversation = Conversation.where(sender_id: params[:message][:to], recipient_id: current_user.id)
    else
      conversation = Conversation.where(sender_id: current_user.id, recipient_id: params[:message][:to]).first_or_create!
    end
    @message = Message.new(params[:message])
    @message.conversation_id = conversation.id
    @message.user_id = current_user.id
    if @message.save
      redirect_to conversation_path(@message.conversation)
    else
      render :back
    end
  end
  
end