class Conversation < ActiveRecord::Base
  attr_accessible :recipient_id, :sender_id
  
  has_many :messages
  
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
end
