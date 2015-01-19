class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(session_params)
    if @user.nil?
      flash[:errors] = ["Can't find user."]
      @user = User.new(session_params)
      render :new
    else
      login_user!
      redirect_to cats_url
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    Session.find_by(token: session[:token]).destroy!
    session[:token] = nil
    redirect_to cats_url
  end

  private

   def session_params
     params.require(:user).permit(:user_name, :password)
   end

end
