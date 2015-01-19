class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render(json: @user.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: @user
    else
      render(json: @user.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: @user
  end

  def contacts
    @user = User.find(params[:id])
    render json: @user.contacts
  end

  def comments
    @user = User.find(params[:id])
    render json: @user.comments
  end

  def favorites
    @user = User.find(params[:id])
    @self_favs = @user.contacts.where(favorite: true)
    @shared_favs = @user.shared_contacts.where(favorite: true)
    render json: (@self_favs + @shared_favs)
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end
end
