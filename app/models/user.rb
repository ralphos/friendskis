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
    # just get albums here and then below use the album to get photos via connections
    albums = facebook.get_connections(uid, "albums")
    covers = albums.map { |h| { id: h["id"], cover_photo: h["cover_photo"] } }
    covers.map { |c| { id: c[:id], cover_photo: facebook.get_object(c[:cover_photo])["images"][5]["source"] } }
  end
  
  def album_photos(album_id)
    facebook.get_connections(album_id, "photos")
  end
  
  def get_photos
    album_hash = facebook.get_connections(uid, "albums")
    album_ids = album_hash.map { |h| h["id"] }
    album_photos = facebook.get_connections(album_ids[1], "photos")
    photo_links = album_photos.map { |h| h["images"] }
    photos = photo_links.map { |photo_set| photo_set.values_at(3, 4) }
  end
end
