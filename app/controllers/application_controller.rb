class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_facebook_cookie

  private
  
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  def current_user
    if session[:user_id].present?
      @current_user ||= User.find(session[:user_id])
    end 

    # If the sign in from facebook didn't work. Get from signed request (Safari workaround)
    unless @current_user
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
    if params[:signed_request]
      koala = Koala::Facebook::OAuth.new FB_APP_ID, FB_SECRET

      signed_params = koala.parse_signed_request(params[:signed_request])
      @fb_user_id = signed_params["user_id"] if signed_params

      session[:fb_user_id] = cookies[:fb_user_id] = @fb_user_id if @fb_user_id.present?
    end

    if @fb_user_id.blank?
      @fb_user_id = request.headers['HTTP_X_FB_ID']
      session[:fb_user_id] = cookies[:fb_user_id] = @fb_user_id if @fb_user_id.present?
    end

    if @fb_user_id.blank? && get_session[:fb_user_id]
      @fb_user_id = get_session[:fb_user_id]
      session[:fb_user_id] = cookies[:fb_user_id] = @fb_user_id if @fb_user_id.present?
    end

    if @fb_user_id.blank? && cookies[:fb_user_id]
      @fb_user_id = cookies[:fb_user_id]
      session[:fb_user_id] = cookies[:fb_user_id] = @fb_user_id if @fb_user_id.present?
    end

    @fb_user_id
  end

  def get_session
    if has_session_in_header?
      logger.info "Reading session from header"
      return @header_session if @header_session
      encrypted_session = request.headers['X-Session']
      secret = Friendskis::Application.config.secret_token
      verifier = ActiveSupport::MessageVerifier.new(secret, 'SHA1')
      @header_session = verifier.verify(encrypted_session).with_indifferent_access
    else
      logger.info "Reading session from cookies"
      session
    end
  end

  # Session present in request header (for CJAX requests)
  def has_session_in_header?
    !!(request.headers['X-Session'])
  end




end
