class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user

  def current_user

    user = User.find_by(session_token: session[:session_token])
    if user
      return @current_user = user
    else
      nil
    end
  end

end
