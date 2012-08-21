class ConversationsController < ApplicationController
  
  def index
    
  end
  
  def show
    @conversation = Conversation.where(id: params[:id]).first
    @messages = @conversation.messages
  end
end