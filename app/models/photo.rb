class Photo < ActiveRecord::Base
  attr_accessible :caption, :tiny_url, :large_url, :medium_url, :thumbnail_url, :user_id, :profile_pic
  
  belongs_to :user

  validates :caption, length: { maximum: 240 }

  has_many :likes

  def like!(u)
    likes.create!(photo:self, user: u)
    self.rank_updated_at = DateTime.now
    self.save
  end

  def liked?(u)
    likes.where(user_id: u.id).count > 0
  end
end
