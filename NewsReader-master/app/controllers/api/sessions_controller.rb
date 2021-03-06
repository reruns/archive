class Api::SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user
      log_in(user)
      render json: user
    else
      render json: "Invalid username or password.", status: 422
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
