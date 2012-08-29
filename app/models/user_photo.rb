class UserPhoto < ActiveRecord::Base
  attr_accessible :photo_id, :user_id
  
  belongs_to :user
  belongs_to :photo
  
  scope :recent, order('created_at DESC')
  
  def self.latest_photos(u)
    case u.preference
    when '1'
      users = User.where(preference: '2', date_of_birth: (u.max_age.years.ago)..(u.min_age.years.ago))
    when '2'
      users = User.where( preference: '1', date_of_birth: (u.max_age.years.ago)..(u.min_age.years.ago))
    end      
    Photo.where(:user_id => users).order('created_at desc')
  end
end

# Will need to add in geospatial querying here somehow!