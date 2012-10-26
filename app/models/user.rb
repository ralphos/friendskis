class User < ActiveRecord::Base
  attr_accessible :username, :date_of_birth, :preference, :min_age, :max_age, :location, :profile_pic, :bio, :is_first_login, :subscription_id, :subscription_status, :link
  
  has_many :photos, dependent: :destroy

  has_many :visitors
  has_many :sender_conversations, class_name: 'Conversation', foreign_key: :sender_id, dependent: :destroy
  has_many :recipient_conversations, class_name: 'Conversation', foreign_key: :recipient_id, dependent: :destroy 

  validates :username, presence: true
  validates :username, length: { in: 4..16 }
  validates :username, uniqueness: { case_sensitive: false }

  scope :recent, order: "created_at desc"

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.link = auth.extra.raw_info.link
      user.email = auth.info.email
      user.gender = auth.extra.raw_info.gender
      user.location = auth.info.location
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.username = auth.extra.raw_info.username
      user.save!
    end
  end

  def subscriber?
    self.subscription_status == "active" 
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

  # def get_location_id
  # end
  
  def conversations
    Conversation.where(["sender_id = ? OR recipient_id = ?", self.id, self.id]).order("updated_at desc")
    # (sender_conversations + recipient_conversations).sort { |a, b| a.updated_at <=> b.updated_at }.reverse
  end
  
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end
  
  def albums
    albums = self.facebook.get_connections(uid, "albums")
    albums.map { |h| { id: h["id"], name: h["name"], count: h["count"], cover_photo: facebook.get_picture(h["cover_photo"]) } }
  end
  
  def album_photos(album_id)
    photos = facebook.get_connections(album_id, "photos")
    photos.map { |h| { thumbnail_url: h["images"][6]["source"], medium_url: h["images"][4]["source"] } }
  end
  
  def profile_photos
    albums = facebook.get_connections(uid, "albums")
    profile_album = albums.select { |a| a["name"] == "Profile Pictures" }
    if profile_album.any?
      photo_hash = facebook.get_connections(profile_album.first["id"], "photos")
      photo_hash.map { |h| { tiny_url: h["images"][7]["source"], thumbnail_url: h["images"][6]["source"], medium_url: h["images"][4]["source"] } }
    else
      # ... return nothing
    end
  end
  
  def age
    ((Date.today - date_of_birth) / 365).floor
  end

  def latest_user_photos
    self.photos.order("created_at desc")
  end


  def total_likes
    Like.where("created_at > ?", 1.week.ago).where(photo_id: photos.collect(&:id)).count
  end

  def computed_score
    if total_likes.to_f > 0 && photos.count.to_f > 0
      ((total_likes.to_f / photos.count.to_f) * photos.count.to_f * 100.0).round
    else
      0
    end
  end

  def compute_score!
    update_attribute(:score, computed_score)
  end

  def compute_percent_score(max_factor)
    (score.to_f / max_factor.to_f).round
  end

  def compute_percent_score!(max_factor)
    update_attribute(:percent_score, compute_percent_score(max_factor))
  end

  def self.max_score
    user = User.order("score desc").first
    max_score = user.score
  end

  def self.compute_rankings!
    max_factor = self.max_score.to_f / 100.0
    self.all.each { |u| u.compute_percent_score!(max_factor) }
  end

  def self.compute_scores!
    self.all.each { |u| u.compute_score! }
  end


end
