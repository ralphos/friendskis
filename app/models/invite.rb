class Invite < ActiveRecord::Base 
  
  attr_accessible :fb_uid, :user_id, :fb_request_id, :concat_request_field, :accepted_invite
  belongs_to :user

  def self.accept_invites(request_ids)
    request_ids.split(',').each do |i|
      invite = self.where(fb_request_id: i).first
      if invite
        invite.accept_invite!
      end
    end
  end

  def accept_invite!
    delete_url = "https://graph.facebook.com/#{concat_request_field}?access_token=#{CGI.escape(APP_ACCESS_TOKEN)}"
    response = RestClient.delete(delete_url)
    self.update_attribute(:accepted_invite, true) if response == "true"
  end
end
