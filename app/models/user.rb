class User < ActiveRecord::Base
  # attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid
  
  has_many :photos

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
  
  def album_covers
    albums = facebook.get_connections(uid, "albums")
    albums.map { |h| { id: h["id"], cover_photo: facebook.get_object(h["cover_photo"])["images"][5]["source"] } }
  end
  
  def album_photos(album_id)
    facebook.get_connections(album_id, "photos")
  end
  
end
