class SessionsController < ApplicationController

  before_action :logged_in?, only: [:create, :new] 

  def new
    render :new
  end



  def create
    @user = User.find_by_credentials(params[:user][:user_name],
                                    params[:user][:password])

    if @user
      @user.reset_session_token
      login_user!
      # session[:session_token] = user.reset_session_token
      redirect_to cats_url
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token
      session[:session_token] = nil
    end

    redirect_to new_sessions_url
  end


end
