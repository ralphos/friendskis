module ApplicationHelper
  
  def profile_pic_small
    image_tag(Photo.find(current_user.profile_pic).thumbnail_url)      
  end
  
  def profile_pic_medium
    image_tag(Photo.find(current_user.profile_pic).medium_url)
  end
  
  def display_sex(user)
    if user.gender == "male"
      "M" 
    elsif user.gender == "female"
      "F"
    else
      "-"
    end 
  end
  
  def criteria(user)
    if user.preference == '1'
      "Looking for men"
    elsif user.preference == '2'
      "Looking for women"
    end
  end
end
