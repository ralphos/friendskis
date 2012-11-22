class Invite < ActiveRecord::Base
  attr_accessible :fb_uid, :user_id, :fb_request_id, :concat_request_field

  belongs_to :user
end
