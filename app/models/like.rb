class Like < ActiveRecord::Base
  attr_accessible :photo_id, :user_id, :photo, :user

  belongs_to :user
  belongs_to :photo

  validates_uniqueness_of :user_id, scope: :photo_id
end
