class Message < ActiveRecord::Base
  attr_accessible :body, :conversation_id, :user_id, :to
  
  belongs_to :conversation
  belongs_to :user
end
