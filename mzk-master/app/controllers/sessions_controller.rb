class SessionsController < ApplicationController
  #Users can log in and log out
  def create
    #resets appropriate user's session_token and session[:session_token]
    user = User.find_by_credentials(params[:user]["email"], params[:user]["password"])

    if user.nil?
      flash.now[:errors] = ["Incorrect email or password."]
      render :new
    else
      login_user!(user)
      redirect_to bands_url
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

  def new
    render :new
  end
end
