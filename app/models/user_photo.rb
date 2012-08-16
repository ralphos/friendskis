class UserPhoto < ActiveRecord::Base
  attr_accessible :photo_id, :user_id
  
  belongs_to :user
  belongs_to :photo
  
  scope :recent, order('created_at DESC')
  
  def self.latest_photos
    latest = UserPhoto.recent
    photo_collection = latest.map do |rec|
      Photo.where(id: rec.photo_id)
    end
    photo_collection.flatten!
  end
end
