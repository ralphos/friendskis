module ApplicationHelper
  
  def recipients_profile_pic(id)
    user = User.where(id: id).first
    Photo.find(user.profile_pic).tiny_url
  end
  
  def profile_pic_tiny(user)
    if user.profile_pic.nil?
      "'/images/def_profile.jpg'"
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
  
  def sex_preference(user)
    case user.preference
    when '1'
      'guys'
    when '2'
      'girls'
    end
  end
  
  def criteria(user)
    case user.preference
    when '1'
      "Interested in men"
    when '2'
      "Interested in women"
    end
  end

  def popularity_label(user)
    if current_user.percent_score <= 25
      "<span class='label notice'>Low</span>".html_safe
    elsif current_user.percent_score > 25 && current_user.percent_score <= 50
      "<span class='label warning'>medium</span>".html_safe
    elsif current_user.percent_score > 50 && current_user.percent_score <= 75 
      "<span class='label success'>High</span>".html_safe
    elsif current_user.percent_score > 75 && current_user.percent_score <= 100
      "<span class='label important'>Hot</span>".html_safe
    end
  end
    
end
