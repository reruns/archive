class SubsController < ApplicationController
  before_action :mod_status_redirect, only: [:edit, :update]

  def mod_status_redirect
    @sub = Sub.find(params[:id])
    unless @sub.moderator_id == self.moderator_id
      redirect_to sub_url(@sub)
    end
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user_id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def edit
    render :edit
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def update
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end
end
