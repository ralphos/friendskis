class ConversationsController < ApplicationController
  
  def index
    @conversations = current_user.conversations
  end
  
  def show
    @conversation = Conversation.where(id: params[:id]).first
    @messages = @conversation.messages
    @message = Message.new
  end

  def update
    @conversation = Conversation.find(params[:id])
    if params[:sender_unlocked]
      @conversation.sender_unlocked = true
    elsif params[:recipient_unlocked]
      @conversation.recipient_unlocked = true
    else
      # ... Do nothing
    end
      @conversation.save
      redirect_to conversation_url(@conversation)
  end
end
