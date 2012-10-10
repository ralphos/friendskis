FactoryGirl.define do
  factory :photo do
    user
    caption 'The Caption'
    tiny_url 'http://example.com/tiny.jpg'
    thumbnail_url 'http://example.com/thumbnail.jpg'
    medium_url 'http://example.com/medium.jpg'
    large_url 'http://example.com/large.jpg'
    profile_pic true
  end
end
