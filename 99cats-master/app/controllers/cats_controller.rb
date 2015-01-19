class CatsController < ApplicationController

  before_action :find_cat, only: [:show, :edit, :update]
  before_action :check_cat_ownership, only: [:edit, :update]
  before_action :require_login, only: [:new, :create, :edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @requests = @cat.rental_requests.order(:start_date)
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def find_cat
    @cat = Cat.find(params[:id])
  end

  def cat_params
    params.require(:cat).permit(:name,:color,:birth_date,:sex,:description)
  end
end
