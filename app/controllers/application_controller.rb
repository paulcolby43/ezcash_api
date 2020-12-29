class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods  
  include ActionController::MimeResponds
  
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json{ render :json => {message: 'Forbidden'}, :status => 403 }
    end
  end

  def auth_header
    request.headers['Authorization']
  end
  
  def token
    if auth_header()
    token = auth_header.split(' ')[1]
#    token = request.authorization.split(' ').last
    end
  end
  
  def logged_in?
    !!current_user
  end
  
  def current_user
    if token()
      @current_user = User.find_by(api_auth_token: token)
    end
  end
  
#  def current_user
#    unless request.authorization.blank?
#      token = request.authorization.split(' ').last
#      @user = User.find_by(api_auth_token: token)
#    end
#  end

protected

def authenticate
  Rails.logger.debug "****************#{request.authorization}"
  authenticate_or_request_with_http_token do |token, options|
    user = User.find_by(api_auth_token: token)
    unless user.blank?
      # Compare the tokens in a time-constant manner, to mitigate timing attacks.
      ActiveSupport::SecurityUtils.secure_compare(user.api_auth_token, token)
    else
      # Keep the timing the same, even if don't find a user
      ActiveSupport::SecurityUtils.secure_compare("no", "token")
    end
  end
end
  
end
