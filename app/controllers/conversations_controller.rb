class ConversationsController < ApplicationController
  
  def index
    @conversations = current_user.conversations
  end
  
  def show
    @conversation = Conversation.where(id: params[:id]).first
    @messages = @conversation.messages
  end
end