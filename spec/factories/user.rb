FactoryGirl.define do
  factory :user do
    name 'Ralph'
    username 'test'
    uid '123456'
    email 'test@example.com'
    gender 'male'
    location 'Manila, Philippines'
    oauth_token '1234567'
    date_of_birth '03/09/1985'
    preference '1'
    max_age '30'
    min_age '15'
  end
end
