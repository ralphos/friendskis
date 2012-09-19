class User < ActiveRecord::Base
  attr_accessible :username, :date_of_birth, :preference, :min_age, :max_age, :location, :profile_pic, :bio
  
  has_many :photos, dependent: :destroy
  has_many :visitors
  has_many :sender_conversations, class_name: 'Conversation', foreign_key: :sender_id, dependent: :destroy
  has_many :recipient_conversations, class_name: 'Conversation', foreign_key: :recipient_id, dependent: :destroy 

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

  def recent_photos
    photos.order('created_at DESC')
  end

  def visitor_photos
    visitor_ids = self.visitors.map { |v| v.visitor_id }
    visitors = User.where(id: visitor_ids).reject { |v| v.id == id }
    profile_pic_ids = visitors.map { |v| v.profile_pic }
    Photo.where(id: profile_pic_ids)
  end
  
  def get_birthday
    # I'm sure there is a better way to do this. Date.parse?? strptime? Refactor this please.
    fb_hash = self.facebook.get_object(uid)
    fb_birthday = fb_hash["birthday"].split('/')
    month, day, year  = fb_birthday[0], fb_birthday[1], fb_birthday[2]
    self.date_of_birth = "#{year}-#{month}-#{day}"
    self.save!
  end
  
  def conversations
    Conversation.where(["sender_id = ? OR recipient_id = ?", self.id, self.id]).order("updated_at desc")
    # (sender_conversations + recipient_conversations).sort { |a, b| a.updated_at <=> b.updated_at }.reverse
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
    photos.map { |h| { thumbnail_url: h["images"][6]["source"], medium_url: h["images"][4]["source"] } }
  end
  
  def profile_photos
    albums = facebook.get_connections(uid, "albums")
    profile_album = albums.select { |a| a["name"] == "Profile Pictures" } # What if they don't have an album with profile pictures (they prob will)
    photo_hash = facebook.get_connections(profile_album.first["id"], "photos")
    photo_hash.map { |h| { tiny_url: h["images"][7]["source"], thumbnail_url: h["images"][6]["source"], medium_url: h["images"][4]["source"] } }
  end
  
  def age
    ((Date.today - date_of_birth) / 365).floor
  end

  def latest_user_photos
    self.photos.order("created_at desc")
  end
  
end
