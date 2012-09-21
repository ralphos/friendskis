OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # Set up ENV variables
  if Rails.env == "production"
    provider :facebook, '386324544771493', '775dfc20bc0f9461e86a383d83b52a1e',
    scope: 'email,user_photos,user_birthday,user_location' 
  else
    provider :facebook, '360375230710287', 'b7781e53494b4ec7f7162b834fcbab57',
    scope: 'email,user_photos,user_birthday,user_location' 
  end
end
