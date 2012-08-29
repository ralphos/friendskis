module ApplicationHelper
  
  def recipients_profile_pic(id)
    user = User.where(id: id).first
    Photo.find(user.profile_pic).tiny_url
  end
  
  def profile_pic_tiny(user)
    if user.profile_pic.nil?
      'default_profile.jpeg'
    else
      Photo.find(user.profile_pic).tiny_url
    end
  end
  
  def profile_pic_small(user)
    Photo.find(user.profile_pic).thumbnail_url      
  end
  
  def profile_pic_medium(user)
    Photo.find(user.profile_pic).medium_url
  end
  
  def display_sex(user)
    case user.gender
    when "male"
      "M"
    when "female"
      "F"
    else
      "-"
    end
  end
  
  def criteria(user)
    case user.preference
    when '1'
      "Looking for men"
    when '2'
      "Looking for women"
    end
  end
    
end
