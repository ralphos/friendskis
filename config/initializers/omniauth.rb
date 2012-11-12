OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # Set up ENV variables
  if Rails.env == "production"
    provider :facebook, '386324544771493', '775dfc20bc0f9461e86a383d83b52a1e',
    scope: 'email,user_photos,user_birthday,user_location', iframe: true

    FB_APP_ID = '386324544771493'
    FB_SECRET = '775dfc20bc0f9461e86a383d83b52a1e'
  else
    provider :facebook, '182721585186027', 'acce0a1b053db8895ab4f4892ca6c599',
    scope: 'email,user_photos,user_birthday,user_location', iframe: true
    FB_APP_ID = '182721585186027'
    FB_SECRET = 'acce0a1b053db8895ab4f4892ca6c599'
  end
end

if Rails.env == "production"
  OmniAuth.config.full_host = 'https://apps.facebook.com/friendskis'
end
