class Message < ActiveRecord::Base
  attr_accessible :body, :conversation_id, :user_id, :recipients_id, :recipients_username
  
  validates_presence_of :recipients_username
  validates_presence_of :body
  
  belongs_to :conversation
  belongs_to :user

end
