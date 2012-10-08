class Photo < ActiveRecord::Base
  attr_accessible :caption, :tiny_url, :large_url, :medium_url, :thumbnail_url, :user_id, :profile_pic
  
  belongs_to :user

  validates :caption, length: { maximum: 240 }
  
end
