class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_facebook_cookie
  before_filter :detect_facebook

  private
  
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  def current_user
    @current_user ||= User.find(session[:user_id]) if @current_user.blank? && session[:user_id]

    # If the sign in from facebook didn't work. Get from signed request (Safari workaround)
    if @current_user.blank? && fb_user_id.present?
      @current_user ||= User.where(uid: fb_user_id).first if fb_user_id
    end

    @current_user
  end

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url, :alert => "Access denied."
    end
  end

  def authenticate_user!
    if !current_user
      redirect_to root_url, :alert => 'You need to sign in for access to this page.'
    end
  end

  def set_facebook_cookie
    response.headers['P3P'] = 'CP="IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT"'

    fb_app_id = '182721585186027'  

    if Rails.env.production?
      fb_app_id = '386324544771493'
    end

    if params[:signed_request]
      cookies["sr_#{fb_app_id}"] = params[:signed_request]
    else     
      params[:signed_request] = cookies["sr_#{fb_app_id}"]
    end

    Rails.logger.info "Signed Request: #{params[:signed_request]}"
  end

  def fb_user_id
    koala = Koala::Facebook::OAuth.new '386324544771493', '775dfc20bc0f9461e86a383d83b52a1e'
    @fb_user_id = koala.parse_signed_request(params[:signed_request])
  end

  def detect_facebook
    @fb_user_id = request.headers['HTTP_X_FB_ID']
    logger.info "FACEBOOK ID: #{@fb_user_id}"
  end

end
