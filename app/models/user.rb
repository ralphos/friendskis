class User < ActiveRecord::Base
  # attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid

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
  
  def get_profile_photos
    album_hash = facebook.get_connections(uid, "albums")
    album_ids = album_hash.map { |h| h["id"] }
    album_photos = facebook.get_connections(album_ids[1], "photos")
    photo_links = album_photos.map { |h| h["images"][5] }
    photo_links.map { |l| l["source"] }
  end
end
