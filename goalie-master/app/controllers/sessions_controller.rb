class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to user_goals_url(current_user)
    else
      render :new
    end
  end

  def create
    @user = User.find_by_credentials(params[:username], params[:password])
    if @user
      log_in!(@user)
    else
      flash.now[:errors] = ["Username/password was incorrect."]
      render :new
    end
  end

  def destroy
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
