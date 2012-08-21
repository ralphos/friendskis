class User < ActiveRecord::Base
  attr_accessible :username, :date_of_birth, :preference, :min_age, :max_age, :location, :profile_pic
  
  has_many :photos, dependent: :destroy
  has_many :conversations, foreign_key: :sender_id
  has_many :conversation, foreign_key: :recipient_id # Not sure if it's necessary to have two foreign keys for the same thing here?

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.gender = auth.extra.raw_info.gender
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end
  
  def albums
    albums = facebook.get_connections(uid, "albums")
    albums.map { |h| { id: h["id"], name: h["name"], count: h["count"], cover_photo: facebook.get_object(h["cover_photo"])["images"][5]["source"] } }
  end
  
  def album_photos(album_id)
    photos = facebook.get_connections(album_id, "photos")
    photos.map { |h| { thumbnail_url: h["images"][5]["source"], medium_url: h["images"][4]["source"] } }
  end
  
  def profile_photos
    albums = facebook.get_connections(uid, "albums")
    profile_album = albums.select { |a| a["name"] == "Profile Pictures" } # What if they don't have an album with profile pictures (they prob will)
    photo_hash = facebook.get_connections(profile_album.first["id"], "photos")
    photo_hash.map { |h| { tiny_url: h["images"][7]["source"], thumbnail_url: h["images"][5]["source"], medium_url: h["images"][4]["source"] } }
  end
  
  def age
    ((Date.today - date_of_birth) / 365).floor
  end
  
  def latest_user_photos
    Photo.where(user_id: self.id).order("created_at desc")
  end
  
end
