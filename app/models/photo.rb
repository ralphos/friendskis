class Photo < ActiveRecord::Base
  attr_accessible :caption, :large_url, :medium_url, :thumbnail_url, :user_id
  
  belongs_to :user
  
end
