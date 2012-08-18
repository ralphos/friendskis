class Photo < ActiveRecord::Base
  attr_accessible :caption, :large_url, :medium_url, :thumbnail_url, :user_id, :profile_pic
  
  belongs_to :user
  
end
