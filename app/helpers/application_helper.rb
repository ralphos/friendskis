module ApplicationHelper
  
  def profile_pic_small
    image_tag(Photo.find(current_user.profile_pic).thumbnail_url)      
  end
  
  def profile_pic_medium
    image_tag(Photo.find(current_user.profile_pic).medium_url)
  end
end
