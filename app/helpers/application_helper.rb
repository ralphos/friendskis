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
    else 
      "Interested to meet people"
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
    
  def nav_class(link_path)
    class_name = current_page?(link_path) ? 'active' : ''
  end

  def page_metadata
    out = {}
    session_key      = Rails.application.config.session_options[:key]
    out['session']   = cookies[session_key]
    out['csrfParam'] = Rack::Utils.escape_html(request_forgery_protection_token)
    out['csrfToken'] = Rack::Utils.escape_html(form_authenticity_token)
    out['appUrl']    = "https://apps.facebook.com/friendskis"
    out
  end


  
  def facebook_iframed_url
    #"#{$fb_url}#{request.path}" 
    if session[:return_to].present?
      "https://apps.facebook.com/friendskis/?go=#{session[:return_to]}"
    else
      "https://apps.facebook.com/friendskis"
    end
  end

  def authenticate_url
    "#{root_url}auth/facebook"
  end


end
