class Invite < ActiveRecord::Base
  attr_accessible :fb_uid, :user_id

  belongs_to :user
end
