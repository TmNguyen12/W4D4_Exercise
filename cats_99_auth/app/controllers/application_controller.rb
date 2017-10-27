class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!
      session[:session_token] = @user.session_token
  end

  def logged_in?
    redirect_to cats_url if !!current_user
  end

end
